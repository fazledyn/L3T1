package offline4.problem2;

public interface Mediator {

    public void addRequest(String consumer, String service);
    public String serveRequest(String providerName);

}
