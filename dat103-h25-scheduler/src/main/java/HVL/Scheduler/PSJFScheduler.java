package HVL.Scheduler;

import java.util.*;
import java.util.stream.Collectors;

public class PSJFScheduler implements Scheduler {

    private Queue<Task> ready;
    private Task selected;

    PSJFScheduler() {
        this.ready = new ArrayDeque<>();
        this.selected = null;
    }

    @Override
    public Optional<Integer> scheduled() {
        if(selected == null) return Optional.empty();
        return Optional.of(selected.getId());
    }

    @Override
    public List<Integer> ready() {
        return ready.stream().map(Task::getId).toList();
    }

    // Subtask 2(a): Complete the implementation of Preemptive Shortest Job First    
    @Override
    public void addTask(Task task) {
        /* Hvis Oppgaven ikke er ferdig blir den putta inn i en liste som sorteres i add */
         ready.add(task);
         ready = ready.stream().sorted(Comparator.comparingInt(Task::getRemaining))
                .collect(Collectors.toCollection(ArrayDeque::new));

    }

    @Override
    public void schedule() {
        if(selected == null) {
            selected = ready.poll();          
            if(selected == null) {            
                return;                       
            }                                 
            selected.start();                 
        } else {                              
	    // Subtask 2(a): Complete the implementation of Preemptive Shortest Job First    
	        if (selected.isDone()) {
                selected.stop();
                selected = null;
                schedule();
            } else if (ready.peek() != null && ready.peek().getRemaining() < selected.getRemaining()) { //Sjekk om det er gjenstående tid på oppgaven
                selected.stop();
                addTask(selected);
                selected = null;
                schedule();
            }
        }                                    
    }

}
