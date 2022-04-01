Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253614EE930
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiDAHoj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbiDAHoi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 03:44:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D525ECAF;
        Fri,  1 Apr 2022 00:42:49 -0700 (PDT)
Date:   Fri, 1 Apr 2022 09:42:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648798967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TrMSX3+gQilz8a7VNHdVxgsogGZEoAnFBXl8tPxCkps=;
        b=xRcTCcl+csECfBYuNeNbcoKWCk5bkTzdHZkh5H4ondpwyQ+mRfNAxVURLZ7BZMZ1nXodyz
        0RdC+akthA17UUMCGhlJJGtTRKpueBs+Mv0k07cJ0OQyxrvgsPNrQZDxjKTzAbDXkK3O3k
        K/76cJx6ROrJi1G0DpVO/Qed01wyS1nCY/CNwBzsweCWieBVUi+jK6mJolTX4GWKFZmaJh
        xPBXvtjwjN4BOJPzegIWlxJ85o4ZDRJp6XnOG8IcMcERx1iHygjV9hYJ6uiRCBtQZ7TyPO
        mJ8wQzuIVRADijqlu6b8jOb0rZuUVe7njPkkt5K3wFpYzrgKpftD5QDE0NT4nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648798967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TrMSX3+gQilz8a7VNHdVxgsogGZEoAnFBXl8tPxCkps=;
        b=vntOswetkOSyBNw8nZmY0lvQccpo4n9jTQXXWNro3shzUqYzmw8U7y18KhVz7XtmsQ0jUP
        lu4mxX+xZNpxX9DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Message-ID: <Ykas9iX/D3WURx8T@linutronix.de>
References: <20220331151654.184433-1-javierm@redhat.com>
 <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
 <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-04-01 00:19:57 [+0200], Javier Martinez Canillas wrote:
> > In case of (CONFIG_PREEMPT_RT=y && CONFIG_EFI_DISABLE_RUNTIME=n),
> > shouldn't we add a small message in the kernel log warning that EFI
> > runtime services are enabled for the RT kernel?
> >
> > In almost all HW, except custom ones with "verified" firmware, such a
> > warning would be useful... This is especially true since in the embedded
> 
> I considered that as well but was not sure about what that message should be.

This makes sense and we had this in the past but dropped it for some
reason.

> Since it will be printed even on systems whose EFI firmwares do not
> have such long call times as the ones described in the commit that
> disabled the runtime services for RT.
> 
> And in that case the warning may be misleading and make users believe
> that a problem exists, which might not be accurate.

Does this matter? The efi-rtc driver is known to cause latencies but it
does not happen if the driver is not used. The same is probably true for
efi-vars: It won't cause high latencies on _read_ but then a certain
number of bit flips during read _may_ lead to write+erase which will
cause higher latencies.
Having a warning at boot (similar to trace_printk's warning) with the
options listed that are known to case high latencies might be a help.
There are some options that nobody will argue about like LOCKDEP. Then
there are other like WATCHDOG or this one, where a debate might start ;)

> Best regards,
> Javier

Sebastian
