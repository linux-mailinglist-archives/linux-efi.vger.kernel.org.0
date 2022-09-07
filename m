Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E885AFF70
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIGIoh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIGIob (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 04:44:31 -0400
X-Greylist: delayed 791 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 01:44:14 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D07CEA3D77;
        Wed,  7 Sep 2022 01:44:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BE3772B058E5;
        Wed,  7 Sep 2022 04:22:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 04:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662538946; x=1662542546; bh=X79Bowixk2
        UfvY4aNNNBf2XN1vgN+OVQkvEi3n41B/0=; b=FHq3eWsWbj7AeTTcT3sCiG2Gid
        zoMcoGnX87QaDKCL9Klc4femUTSwemZiQ3qSZVwFlxvWnOSM7bX1ZQzTRZr/ntO/
        rUHgfMfaMnw/547ubHfdDxNcdibTQ2teOF/7DV2qlAmttNSlW7d5iyhtiWg/uUDJ
        lO5qL1F586qegEJupGnmnHsI1IuCp/ImB2pbQwWZ70GdaaWn+oyXtexephhYdXmV
        SQislyNm+YIIa72TtD5MTVU7il9ysVv6MvEvZIg7XCSWABdf8+1sk/oBKSO3pfZ1
        uvi6NqIm6jxqcFGbLN03EAn7fM7h4L7Oi/Ji5N0dSTsTCHL9kkQrct9oFswQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662538946; x=1662542546; bh=X79Bowixk2UfvY4aNNNBf2XN1vgN
        +OVQkvEi3n41B/0=; b=i2fgw7Lm2RcMVoE6K+rIusyvnZ4lyDN5dx8+fgyWxbIF
        +AqTwmsIDN0yb6WUldLlrs74GDun+0ghaNFmnjAZTG/kG/DTX2Ue6Jo6AoIEGfnp
        m23C0krGK+yRAnjvF9vuguVXjMShUCvrdItalepOHerr8sWvWVCUH+p2pz2BA84o
        9CL/mCBfzT64N5Sg+EM/Sn8zu3t4Mmkl8ZGk/QCKdH6GT+U+UaWKS/+FhXt/OrSz
        UJnDAu8M6YDAc3UEYGHiyeS8WJGorrnO8HOYrXp9DGJehh1+4dezsYWVDALjUEnt
        h56fIcvzomWG4T8yO1l/aiAYb7MXV5HfHSWhSnNe0w==
X-ME-Sender: <xms:wFQYY3OkJ587gJqTFniHmGsoib1jkjdGST-qEVi3IKekB1A8gjk2Ww>
    <xme:wFQYYx9zmv0pewFSnpE2qd-qg4VthrNbv2mqpQ6fzyLh1lG1ncg64YLF8XhxEzdRd
    HxfOqHKeDJhq7DxaTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wFQYY2Q2JbiXtN04GC_Hse6TtfQrs-R6JzVpCd0xqk1-TcpRmNZX_A>
    <xmx:wFQYY7tsyffEhqi73XQbt5gJ44AMPaQ4LgT-tZrwxuBOXwBcKVpCPw>
    <xmx:wFQYY_cRGxurafke8L8pYB345DBK3SybXlKUd3IJpkYtG6W6mxVuLQ>
    <xmx:wlQYYynsfP7agf-9b5bKj6YVeu5IB60g4wd5G4IyoTohz3aQSZ3gRnFKefaSHW1i>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32FE6B60083; Wed,  7 Sep 2022 04:22:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <e2e2a0c7-d859-4255-94b6-b030aa9dc277@www.fastmail.com>
In-Reply-To: <YxfBGDg6YkIQ6Wzq@phenom.ffwll.local>
References: <20220806163255.10404-1-markuss.broks@gmail.com>
 <20220806163255.10404-4-markuss.broks@gmail.com>
 <YxfBGDg6YkIQ6Wzq@phenom.ffwll.local>
Date:   Wed, 07 Sep 2022 10:22:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Daniel Vetter" <daniel@ffwll.ch>,
        "Markuss Broks" <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Helge Deller" <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Michal Suchanek" <msuchanek@suse.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Wei Ming Chen" <jj251510319013@gmail.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Tony Lindgren" <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] efi: earlycon: Add support for generic framebuffers and
 move to console subsystem
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 6, 2022, at 11:52 PM, Daniel Vetter wrote:
> On Sat, Aug 06, 2022 at 07:32:24PM +0300, Markuss Broks wrote:
>
> Ok I have a more fundamental issue with this than the lack of proper patch
> splitting I mentioned in the other thread.
>
> This is the wrong place.
>
> drivers/video/console is about the various vt console implementations,
> which supply a struct consw to con_register_driver.

You are right, that was my mistake. The original patch was for
drivers/video/fbdev/, and I suggested moving it out of there because
it does not depend on the fbdev subsystem, but clearly my suggestions
of drivers/video/console was equally wrong.

> This otoh is an (early) kernel/printk console implemented using struct
> console. Totally different thing, and really shouldn't end up in
> drivers/video/console imo. Somewhere in drivers/firmware might still be
> the best place, the sysfb stuff is also there. Maybe
> drivers/firmware/sysfb_earlycon.c?

drivers/firmware/ is better but doesn't sound great to me either,
since one important thing the patch does is to not make it depend
on EFI firmware or BIOS style screen_info any more. 

Maybe drivers/tty/earlycon_simplefb.c would work better, keeping
it close to the earlycon base support in drivers/tty/serial/,
the vt console and the old simplefb driver/, without tying to too
closely to fbdev of UEFI.

     Arnd
