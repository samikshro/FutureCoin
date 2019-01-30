
public class Future {
	
	private int sellerMargin;
	private int buyerMargin;
	private int sellerAddedMar;
	private int buyerAddedMar;
	private static int price = 200;
	private static final int MAINTENANCE_MARGIN = 10;
	private final int marginLevel;
	private final int days;
	
	public Future(int margin, int days) {
		sellerMargin = margin;
		buyerMargin = margin;
		marginLevel = margin;
		this.days = days;
	}
	
	/**
	 * When it is a new day of trading, set a new price and update margins.
	 */
	private void newDay() {
		int original = Future.generatePrice();
		System.out.println("Price: "+ price);
		int difference = Math.abs(price - original);
		System.out.println("Difference: "+ difference);
		
		if (price < original) {
			buyerMargin -= difference;
			sellerMargin += difference;
		}else if(price > original) {
			buyerMargin += difference;
			sellerMargin -= difference;
		}
		
		if (buyerMargin < marginLevel)
			buyerAddedMar += marginLevel - buyerMargin;
			System.out.println("Added "+buyerAddedMar+"to buyer margin account.");
			addToMargin(1);
		
		if(sellerMargin < marginLevel) {
			sellerAddedMar += marginLevel - sellerMargin;
			System.out.println("Added "+sellerAddedMar+"to seller margin account.");
			addToMargin(0);
		}
		
			
	}
	
	/**
	 * If margin is below MAINTENANCE_MARGIN, add money up to the marginLevel
	 * from the buyer/seller's account to the margin account.
	 */
	private void addToMargin(int who) {
		if (who == 0)
			sellerMargin = marginLevel;
		else
			buyerMargin = marginLevel;
	}
	
	
	/**
	 * Set a new price using random numbers from 0 to 9.
	 */
	private static int generatePrice() {
		int sign = (int) (Math.random()*10);
		int original = price;
		if(sign % 2 == 0)
			price += (int) (Math.random()*10);
		else
			price -= (int) (Math.random()*10);
		return original;
	}
	
	
	
	

}
