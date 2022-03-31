Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D914ED111
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 02:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbiCaAxb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 20:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343836AbiCaAxa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 20:53:30 -0400
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 17:51:44 PDT
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9359A75
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 17:51:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648686970; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K8T+uHskJaos5V9OED/eC2qH+L5so1s+6tCZ8uFNKBYd1R07a3+sjrROp17LseNzQeVLNNk8pxnLWDzuLacO7OCNVsVpTRRPevnJ3gIMgg1wpYkD+V515aCKPeMgrvrZD90jmjT+fpDSJviMy+TeUsylfJW4qaZAUqFsbrzNGcU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648686970; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Fe9LNg1IOgAJF+0EWMxfVT5zQoYnvRy5Xxc7KvtGuW4=; 
        b=QXNKnNKXX510AJBBqUIPOKeOFCznZI7UPw1+5hCJJjfnRb/+M3Mrwfuz+HdQEQ1kxja8DIHQuFezjTloAu+nd+b3BhLlOCa6dHzPhvGm8+XUOOC7jsjDzR495gKZRUW02eTqCeTw+scN9PNWN4vt8Ft39MUl4s4S0fEriktFNSk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648686970;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Fe9LNg1IOgAJF+0EWMxfVT5zQoYnvRy5Xxc7KvtGuW4=;
        b=LQCyc/CUxS/WkQP0SvKojevKcFUuc9/Av94cbbb4+ZzIutO1Ojh3qvzOY3d9nJbB
        fQWnfmmd8F2Hp0FVlAxPUHnfs5hPZqMC0nv1nxj0+AwfIlFM6ETQKJkRDDP+u54BNDG
        HaCdFk6+JbEhG6ciN76flXpruBym/jT8smsFO7a8=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1648686969599709.4131390280043; Wed, 30 Mar 2022 17:36:09 -0700 (PDT)
Message-ID: <c3ecd65f-bb10-8d14-500d-d6e2ece9b336@apertussolutions.com>
Date:   Wed, 30 Mar 2022 20:35:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Kees Cook <keescook@chromium.org>
References: <20220329174057.GA17778@srcf.ucam.org>
 <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Greetings Matthew,

First thank you to you and James for taking time out of your busy
schedules to sit down with us and work through all of this.

Hey Ard,

On 3/30/22 03:02, Ard Biesheuvel wrote:>> 1) From an EFI maintainer
perspective, is making the contract between
>> the boot stub and the kernel explicit viable?
>>
>
> No. The direction of travel has been to define EFI boot only in terms
> of the handover from the loader to the stub. What happens next is up
> to the architecture, and is deliberately not specified, because it is
> considered to be internal Linux ABI. We've deviated from this once for
> Xen on ARM, but this means we have already painted ourselves into a
> corner when it comes the way we use DT internally at the handover
> point between stub and kernel proper, and I am not eager to repeat
> that. Locking down the stub-to-kernel protocol for all architectures
> is not the way to go.

To help provide some visual context, for EFI today there is,

                                        bzImage
[EFI boot manager] -> [[efi-stub] -> [setup kernel] -> [main kernel]]

Where the efi-stub is responsible for interacting with firmware to
configure the system, store that configuration for the setup kernel and
the main kernel, and then call EBS before entering the setup kernel.

For Secure Launch the flow (on Intel) is,

      CPU instruction                   bzImage
[preamble] -> [ACM] -> [[sl-stub] -> [setup kernel] -> [main kernel]]

In order to make the CPU instruction call to enter the ACM the system
must be in a very specific quiescent state. This includes but not
exhaustively,
  * EBS must have been called
  * TPM should have all localities closed
  * IOMMU PMRs must be programmed appropriately
  * TXT heap space allocated
  * TXT heap space populated with config structures
  * All APs must be in a specific idle state
  * Execution is on the BSP
Carrying all this out is what is considered the DRTM preamble.

This is the wrinkle because the setup kernel and main kernel are both
predicated on the efi-stub and the efi-stub is predicated on running
before EBS. So how can this wrinkle be addressed? The TrenchBoot project
proposed that the information collected by the efi-stub be formally
documented for two reasons, 1. to allow the sl-stub to be aware of what
and where all external data is being injected into the kernel so any
data that may be security critical could be measured, and 2. it would
allow third parties, e.g. GRUB, could correctly configure the system,
pass all EFI related information correctly to the setup kernel and the
main kernel before executing the preamble. Where the former is more of a
concern than enabling the latter.

Relating to what information is security critical, this can be a bit
subjective. For example Dave Weston has a twitter thread[1][2][3] over
what state Azure Attestation can validate for a DRTM Windows system.
This reflects what Microsoft believes it's customers will want to
validate about a Windows system before accessing services and data
stored in Azure. For Linux Secure Launch measuring everything would
obviously provide the finest grain of assertions regarding how the
kernel was configured to run but that comes at the expense that is
incurred for taking the measurements. To date the selection of
measurements have been an attempt of balancing the most meaningful
measurements with how many measurements should be taken. For instance it
would be possible to hash the SRTM (firmware) TPM event log to provide
an assertion of what its contents were at dynamic launch. Is that a
meaningful measurement? Not necessarily since there are other means to
validate the log but there is likely someone who is super cautious and
would like to see the extra layer of validation.

>> 2) If so, is it desirable?
>>
>> 3) If either (1) or (2) is "no", is it reasonable to ensure that all
>> potentially security-critical state or configuration changes to the
>> boot stub are reviewed by DRTM people to verify whether the secure
>> launch code needs to be updated to match?
>
> Wouldn't it be better for the secure launch kernel to boot the EFI
> entrypoint directly? As it happens, I just completed a PoC last week
> for a minimal implementation of EFI (in Rust) that only carries the
> pieces that the EFI stub needs to boot Linux. It is currently just a
> proof of concept that only works on QEMU/arm64, but it should not be
> too hard to adapt it for x86 and for booting a kernel that has already
> been loaded to memory.

IIUC, as you can see above, entering the efi-stub from the dynamic
launch will fail because EBS will have been called.

v/r,
dps

[1] https://twitter.com/dwizzzlemsft/status/1508517758635446273
[2] https://twitter.com/dwizzzlemsft/status/1508602527482146816
[3] https://twitter.com/dwizzzlemsft/status/1508852935261794312
