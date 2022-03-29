Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE94EB2D9
	for <lists+linux-efi@lfdr.de>; Tue, 29 Mar 2022 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiC2Rmr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbiC2Rmq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 13:42:46 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4155E33A37;
        Tue, 29 Mar 2022 10:40:59 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 4368C40A73; Tue, 29 Mar 2022 18:40:57 +0100 (BST)
Date:   Tue, 29 Mar 2022 18:40:57 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grub-devel@gnu.org
Subject: Linux DRTM on UEFI platforms
Message-ID: <20220329174057.GA17778@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We're still trying to come to a conclusion about the most maintainable 
approach to getting DRTM implementations like Intel TXT working on UEFI 
platforms under Linux. I'm going to try to summarise the situation here 
- I'm not an expert, so details may be inaccurate, but I think this is 
the rough shape of things.

Under normal circumstances on UEFI platforms, the bootloader (or system 
firmware directly) load the kernel and execute code in the boot stub. 
This boot stub code interacts with the firmware in various ways, 
including working around some platform-specific issues and doing things 
like copying the TPM event log into memory that can be used by the 
kernel proper. While it remains technically possible to boot the kernel 
on x86 UEFI platforms by jumping directly to the kernel entry point and 
skipping the boot stub, this risks disabling certain functionality and 
leaving the kernel in a slightly unexpected state. The contract that 
exists between the UEFI stub and the kernel is not meaningfully 
documented - portions are carried out by updating the contents of the 
bootparams struct on x86 or devicetree on ARM, but other information is 
conveyed via UEFI configuration tables, the boot stub may modify the 
contents of certain UEFI variables, and some of this is implicit in 
the form of hardware state.

The Trenchboot project is attempting to implement DRTM under Linux. 
Traditional measured boot takes the form of a static root of trust - 
each component in the boot chain is measured by the previous component 
before being executed, and each measures what it considers to be 
security relevant configuration and behavioural state. Modifying any 
component will change the measurements, even if the end result is 
equivalent. Dynamic Root of Trust Measurement aims to provide more 
useful measurements by performing a measurement at a specific point in 
time - as a result, DRTM cares only about what the state *is*, not what 
happened before then.

There's a bunch of complexity involved in this that's vendor specific, 
but the short version is that a launch environment is set up and a 
specific CPU instruction executed that triggers a secure launch event. 
The Trenchboot code consists of patches to bootloaders to support 
setting up this environment, and patches to the kernel to provide 
support for the "Secure Launch" kernel that handles DRTM before handing 
control off to the kernel proper, skipping the UEFI boot stub.

Since this skips the UEFI boot stub, it's then the responsibility of the 
bootloader to implement the functionality of the boot stub. This is made 
difficult due to the absence of an express contract between the boot 
stub and the rest of the kernel - our assumption has been that the code 
is the contract, and this is free to change arbitrarily since both the 
producer and the consumer of the information can be updated 
simultaneously and can't get out of sync. That seems to leave us with 
two options:

1) Formalise the contract between the boot stub and the kernel, making 
it easier for other boot loaders to implement the contract. This has the 
downside that even within the scope of the contract we may end up with 
divergent behaviour, and also new functionality in the kernel may not be 
available without the bootloader also being updated.

2) Modify the boot stub such that it can be provided with a callback, 
and instead of jumping to the kernel it can jump to the callback. The 
boot flow would then involve the boot loader setting up the launch 
environment, calling the boot stub code, and then performing the DRTM 
event. This avoids requiring an explicit contract (the boot stub would 
remain part of the kernel image and would be updated in lockstep).

One complexity for both approaches is that the secure launch environment 
needs to be aware of all security-critical state in the system. The 
firmware nominally exposes that information for everything it's aware 
of that's security-critical, but the boot stub may have performed 
security-critical actions or exposed security-critical state that the 
firmware is unaware of. The secure launch code from Trenchboot has to be 
aware of this in order to ensure it's measured.

If there's a contract, then in theory this would be embodied in the 
contract and when the contract is updated the secure launch code could 
also be updated. If there's no contract, every change to the boot stub 
would need to be examined and the secure launch code updated if 
necessary.

While the secure launch code is currently out of tree, the goal is for 
it to be integrated into the kernel tree. My feeling is that it's 
going to be easier to manage this if everything is in tree - ie, all the 
EFI setup code that does anything security-critical is either in the 
firmware (and so the firmware takes responsibility for exposing it) or 
is in the Linux tree (and so we take responsibility for updating the 
secure launch code whenever something relevant changes in the boot 
stub). But this requires support from the EFI maintainers in terms of 
not merging things until we've established whether updates are required 
to the secure launch code. The alternative is effectively the same, 
except it would require updating the contract instead.

But, as mentioned, that's just my feeling - I know that Daniel feels 
that the contract approach is preferable. So:

1) From an EFI maintainer perspective, is making the contract between 
the boot stub and the kernel explicit viable?

2) If so, is it desirable?

3) If either (1) or (2) is "no", is it reasonable to ensure that all 
potentially security-critical state or configuration changes to the 
boot stub are reviewed by DRTM people to verify whether the secure 
launch code needs to be updated to match?
