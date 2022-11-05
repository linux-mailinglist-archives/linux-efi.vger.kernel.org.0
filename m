Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039AE61A739
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 04:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKEDMB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Nov 2022 23:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKEDL7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Nov 2022 23:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A8E27B14
        for <linux-efi@vger.kernel.org>; Fri,  4 Nov 2022 20:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667617856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcIXO4xBoz7ofsfZUzi32Ktqyk3fNvPNgMvPPVFXeew=;
        b=WTrJF3ua1MoJozfmFvBcBPC+GDN27u9FHCnmDbWqvGYeRqDcMppoDJwVC6fYwFlv8xA6qW
        jbRG7J0NrKGVdzEDGU4pjxmc7Z8+AL178SNZcclnlL32YF7gqjr6WWMm7GfPUcWRKEDziL
        9ZXMZNmg1PxyFT+CG2eFe6I4a/Hvtog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-I_GDZKzgOcSc_30tL8XqZw-1; Fri, 04 Nov 2022 23:10:53 -0400
X-MC-Unique: I_GDZKzgOcSc_30tL8XqZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0719B8039A5;
        Sat,  5 Nov 2022 03:10:53 +0000 (UTC)
Received: from localhost (ovpn-13-134.pek2.redhat.com [10.72.13.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 384342166B26;
        Sat,  5 Nov 2022 03:10:49 +0000 (UTC)
Date:   Sat, 5 Nov 2022 11:10:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     ns@tfwno.gf, dyoung@redhat.com
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
Message-ID: <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add Dave to CC

On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> Greetings,
> 
> I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> cause EFI mode (if that's the right term for it) to be unconditionally
> disabled, even when not using the --noefi option to kexec.
> 
> What I mean by "EFI mode" being disabled, more than just EFI runtime
> services, is that basically nothing about the system's EFI is visible
> post-kexec. Normally you have a message like this in dmesg when the
> system is booted in EFI mode:
> 
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> MEMATTR=0x7ec63018
> (obviously not the real firmware of the machine I'm talking about, but I
> can also send that if it would be of any help)
> 
> No such message pops up in my dmesg as a result of this bug, & this
> causes some fallout like being unable to find the system's DMI
> information:
> 
> <6>[    0.000000] DMI not present or invalid.
> 
> The efivarfs module also fails to load with -ENODEV.
> 
> I've tried also booting with efi=runtime explicitly but it doesn't
> change anything. The kernel still does not print the name of the EFI
> firmware, DMI is still missing, & efivarfs still fails to load.
> 
> I've been using the kexec_load syscall for all these tests, if it's
> important.
> 
> Also, to make it very clear, all this only ever happens post-kexec. When
> booting straight from UEFI (with the EFI stub), all the aforementioned
> stuff that fails works perfectly fine (i.e. name of firmware is printed,
> DMI is properly found, & efivarfs loads & mounts just fine).
> 
> This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> bisect it, but it seems like it goes pretty far back. I've got vanilla
> mainline kernel builds dating back to 5.17 that have the exact same
> issue. It might be worth noting that during this testing, I made sure
> the version of the kernel being kexeced & the kernel kexecing were the
> same version. It may not have been a problem in older kernels, but that
> would be difficult to test for me (a pretty important driver for this
> machine was only merged during v5.17-rc4). So it may not have been a
> regression & just a hidden problem since time immemorial.
> 
> I am willing to test any patches I may get to further debug or fix
> this issue, preferably based on the current state of torvalds/linux.git.
> I can build & test kernels quite a few times per day.
> 
> I can also send any important materials (kernel config, dmesg, firmware
> information, so on & so forth) on request. I'll also just mention I'm
> using kexec-tools 2.0.24 upfront, if it matters.
> 
> Regards,
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

