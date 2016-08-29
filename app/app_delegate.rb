class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    documents_path         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    NanoStore.shared_store = NanoStore.store(:file, documents_path + "/nano.db")

    storyboard = UIStoryboard.storyboardWithName("main", bundle: nil)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible
    true
  end
end
