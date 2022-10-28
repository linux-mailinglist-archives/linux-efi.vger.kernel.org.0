Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED6611267
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJ1NLu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJ1NLu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 09:11:50 -0400
X-Greylist: delayed 551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 06:11:46 PDT
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047611C2EAD;
        Fri, 28 Oct 2022 06:11:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tfwno.gf; s=mail;
        t=1666962143; bh=DtqNWOtFT8hw8nEEdF0WNtUoPrpPIt01zfqy5oCYP98=;
        h=Date:From:To:Subject:From;
        b=HFXv+/6hCmM4TKSJ1FVpzgYQgQ05+CzT6N83RncfSJI5p/5NoB7F5BycLwFfO627h
         NPKc+nhle+14LrcO8CpuE2DhIQwe6cv5PUPKXj6Zr7oU2ZIxOk+xjbj51T/+t6hHIN
         3Vqq/i1noAP9mJRAQdEfeD3JC5eyk3RttfIUDbENEr7FdFGoMdcxmtwA3ZQNVFyGHc
         9y2Ho64yPjz5beRlVbYAJa0uoDy2qhuUtB4zM5hit+7DiD8axQcMe/cze3kpb/7lSX
         q3gRFm0Cv5YcdOIaiJzqZM4KfHq6EN22QWxOWCx9bINWR3S6rJZHG4aBnEqaeYuNop
         XlwBpoQ+6wJHQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Oct 2022 13:02:23 +0000
From:   ns@tfwno.gf
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org
Subject: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
Message-ID: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
X-Sender: ns@tfwno.gf
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Greetings,

I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
cause EFI mode (if that's the right term for it) to be unconditionally
disabled, even when not using the --noefi option to kexec.

What I mean by "EFI mode" being disabled, more than just EFI runtime
services, is that basically nothing about the system's EFI is visible
post-kexec. Normally you have a message like this in dmesg when the
system is booted in EFI mode:

[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 
2.0=0x7fb7e014 MEMATTR=0x7ec63018
(obviously not the real firmware of the machine I'm talking about, but I
can also send that if it would be of any help)

No such message pops up in my dmesg as a result of this bug, & this
causes some fallout like being unable to find the system's DMI
information:

<6>[    0.000000] DMI not present or invalid.

The efivarfs module also fails to load with -ENODEV.

I've tried also booting with efi=runtime explicitly but it doesn't
change anything. The kernel still does not print the name of the EFI
firmware, DMI is still missing, & efivarfs still fails to load.

I've been using the kexec_load syscall for all these tests, if it's
important.

Also, to make it very clear, all this only ever happens post-kexec. When
booting straight from UEFI (with the EFI stub), all the aforementioned
stuff that fails works perfectly fine (i.e. name of firmware is printed,
DMI is properly found, & efivarfs loads & mounts just fine).

This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
bisect it, but it seems like it goes pretty far back. I've got vanilla
mainline kernel builds dating back to 5.17 that have the exact same
issue. It might be worth noting that during this testing, I made sure
the version of the kernel being kexeced & the kernel kexecing were the
same version. It may not have been a problem in older kernels, but that
would be difficult to test for me (a pretty important driver for this
machine was only merged during v5.17-rc4). So it may not have been a
regression & just a hidden problem since time immemorial.

I am willing to test any patches I may get to further debug or fix
this issue, preferably based on the current state of torvalds/linux.git.
I can build & test kernels quite a few times per day.

I can also send any important materials (kernel config, dmesg, firmware
information, so on & so forth) on request. I'll also just mention I'm
using kexec-tools 2.0.24 upfront, if it matters.

Regards,
