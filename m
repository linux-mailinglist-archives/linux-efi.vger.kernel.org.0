Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8035841ED
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiG1OlC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 10:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiG1Oko (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 10:40:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649D6A49B;
        Thu, 28 Jul 2022 07:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 180FEB8248F;
        Thu, 28 Jul 2022 14:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2780FC433C1;
        Thu, 28 Jul 2022 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659019115;
        bh=T0SHuXwms0ULhNSk06npqRzjCyjBqf+WMkcyXOh3mVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuZDhK2NfIRhsiGsc3OHq9E6APLfmz1ZzviYgdVlFZyC/0qnjX4D+3cSnhMBRDTp/
         wf5uKznxn7htR92pkdg7knCkxP9XNNayz9JN/DK3r4/UWNaGNnC+wB6tPHeMLsWWyc
         wyYxly+6SmnXdxNg9LBc56Hl3Q+lHMH/HtUSJwp8=
Date:   Thu, 28 Jul 2022 16:38:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] drivers: serial: earlycon: Pass device-tree node
Message-ID: <YuKfaVG/ZbYtFjS/@kroah.com>
References: <20220728142824.3836-1-markuss.broks@gmail.com>
 <20220728142824.3836-2-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728142824.3836-2-markuss.broks@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 28, 2022 at 05:28:18PM +0300, Markuss Broks wrote:
> Pass a pointer to device-tree node in case the driver probed from
> OF. This makes early console drivers able to fetch options from
> device-tree node properties.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  drivers/tty/serial/earlycon.c | 3 +++
>  include/linux/serial_core.h   | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 57c70851f22a0e78805f34d1a7700708104b6f6a..14e8a7fe54486a1c377a6659c37a73858de5bf0b 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -304,6 +304,9 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
>  		strlcpy(early_console_dev.options, options,
>  			sizeof(early_console_dev.options));
>  	}
> +
> +	early_console_dev.node = node;
> +
>  	earlycon_init(&early_console_dev, match->name);
>  	err = match->setup(&early_console_dev, options);
>  	earlycon_print_info(&early_console_dev);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index cbd5070bc87f42aa450c4ca7af8a9b59fbe88574..3295721f33e482124fae8370b5889d5d6c012303 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -349,6 +349,7 @@ struct earlycon_device {
>  	struct uart_port port;
>  	char options[16];		/* e.g., 115200n8 */
>  	unsigned int baud;
> +	unsigned long node;

That should not be an unsigned long, but rather an 'int'.  Something got
messed up, of_setup_earlycon() should be changed to reflect this before
propagating the error to other places in the kernel.

And it's not really a "node" but an "offset", right?

thanks,

greg k-h
