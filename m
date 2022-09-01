Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721265A9EE9
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiIAS3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Sep 2022 14:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIAS3C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Sep 2022 14:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B97CB62;
        Thu,  1 Sep 2022 11:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 301A360B9A;
        Thu,  1 Sep 2022 18:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACC7C433D6;
        Thu,  1 Sep 2022 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662056940;
        bh=PlCL4cySnm15Ux+0EPr8LEeim/gpgor8ir7LBM4lzyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vuTFFXU/OEqKHZMxgSu1J2oOLUFORW1IBflDMHF+L5ALQBpp1DbA/kh9YjhwTOF5h
         R/98kj9n6QiYlSpIATE1ocJpSDFLA8CTzJn29GQ73DSCypT49mbtCQet/xoHjueyQY
         EBifd6Wce5OjHHW34tzOJJ1tI+OAP31Hje9EU67Y=
Date:   Thu, 1 Sep 2022 20:28:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     evgreen@chromium.org, arnd@arndb.de, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@gpiccoli.net, ardb@kernel.org,
        davidgow@google.com, jwerner@chromium.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH V3] firmware: google: Test spinlock on panic path to
 avoid lockups
Message-ID: <YxD56RTI9v/P2QOL@kroah.com>
References: <20220819155059.451674-1-gpiccoli@igalia.com>
 <YxDVPqVkdgQbAIvY@kroah.com>
 <f89cd87c-7d1c-d8e6-ed95-6876f0201872@igalia.com>
 <YxDX9+p+58q2sip2@kroah.com>
 <6bc5dbc3-2cdd-5cb8-1632-11de2008a85a@igalia.com>
 <YxDhiSDs4YcUrqV5@kroah.com>
 <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85683284-db85-7e3a-57bd-750e1c204e3e@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 01, 2022 at 02:46:48PM -0300, Guilherme G. Piccoli wrote:
> On 01/09/2022 13:44, Greg KH wrote:
> > [...]
> >>> How are we supposed to know this here?
> >>>
> >>
> >> Reading the code?
> >> Or you mean, in the commit description this should be mentioned?
> > 
> > Yes, and in the comment as this type of call is very rare and should
> > almost never be used.
> 
> OK, I can add that, for sure.
> 
> 
> >> [...]
> >> I don't think it is so simple - we are in the panic path.
> > 
> > Great, then the lock doesn't matter :)
> > 
> >> So, imagine the lock was taken in CPU0, where GSMI is doing some
> >> operation. During that operation, CPU1 panics!
> >>
> >> When that happens, panic() executes in CPU1, disabling CPU0 through
> >> "strong" mechanisms (NMI). So, CPU0 had the lock, it is now off, and
> >> when CPU1 goes through the panic notifiers, it'll eventually wait
> >> forever for this lock in the GSMI handler, unless we have this patch
> >> that would prevent the handler to run in such case.
> >> Makes sense?
> > 
> > I'm trying to say "if you are in panic, never grab the lock in the first
> > place".  So change the place when you grab the lock, not here.
> > 
> 
> Evan, any comment here?
> I think the patch is still well suited for this case. Suggestions on how
> to improve it are welcome, of course.
> 
> I honestly didn't understand exactly what you're suggesting Greg...
> Mind clarifying?

Something like this totally untested code:

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..6ad41b22671c 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/panic.h>
 #include <linux/panic_notifier.h>
 #include <linux/ioctl.h>
 #include <linux/acpi.h>
@@ -611,6 +612,11 @@ static const struct attribute *gsmi_attrs[] = {
 	NULL,
 };
 
+static bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+
 static int gsmi_shutdown_reason(int reason)
 {
 	struct gsmi_log_entry_type_1 entry = {
@@ -629,7 +635,8 @@ static int gsmi_shutdown_reason(int reason)
 	if (saved_reason & (1 << reason))
 		return 0;
 
-	spin_lock_irqsave(&gsmi_dev.lock, flags);
+	if (!panic_in_progress())
+		spin_lock_irqsave(&gsmi_dev.lock, flags);
 
 	saved_reason |= (1 << reason);
 
@@ -644,7 +651,8 @@ static int gsmi_shutdown_reason(int reason)
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_EVENT_LOG);
 
-	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
+	if (!panic_in_progress())
+		spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
 	if (rc < 0)
 		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");



That being said, are you sure spinlocks are still held in the panic
notifier?  What about the call to bust_spinlocks() that is called in
panic() already?  Wouldn't that have already dropped whatever you were
worried about here?

thanks,

greg k-h
