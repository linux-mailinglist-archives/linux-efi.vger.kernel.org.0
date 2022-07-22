Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F116357E577
	for <lists+linux-efi@lfdr.de>; Fri, 22 Jul 2022 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiGVRYN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Jul 2022 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiGVRYJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Jul 2022 13:24:09 -0400
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC39A685;
        Fri, 22 Jul 2022 10:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658510616; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=oLE/xSyopDRdiQD9by3ZOyYRAzwXvXil06mIY0ZRnhJxilmzIKH5ega5YYyq0l0roHolKUecvLZ2MpWyt1OD55LqeGV+YkpuvEOCu4RwNGABZ8GBd80bx2plFzcZX/ynBKE4gmO1rZk4s08T+nR+eXy1tyKxXXccjMsSgXN1uho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658510616; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=i8J8/49TBgNkUqXEblX9lJU0d7k8Kp9hDHUEwKzEqkk=; 
        b=JoGmMkAHhgVvoXd3jkt/NyzB3EDQBLEkfwMgsyCznNfCnzTXInEFNofgWndgEcXbxlEpNnA7r5BuNLfXulwfuSHzMud0fviGx92Tbzow+O7AibKp7SdbE+cQGLKjk6tN/wU4FiaxReNmzopdXQnksL7ttUjQL5ixhssM3t7yY5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658510616;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=i8J8/49TBgNkUqXEblX9lJU0d7k8Kp9hDHUEwKzEqkk=;
        b=mQ/kSohoTF1EJTSklVNTZZibgQODRpmNIp1lqpPHgE6z7DuEeCZF2C60tIyOgpAc
        p9tp3Ow4zUYAdmG/rthLYovIbp8ayd9OA8tRJkFlzkCIKCw8+Hwf+5M5jEZQEijTxb6
        YoJIc6qk2jRU4qAYd469XWWX7ogUV20jIZ8bkIF8=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1658510614838765.644692493946; Fri, 22 Jul 2022 10:23:34 -0700 (PDT)
Message-ID: <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
Date:   Fri, 22 Jul 2022 13:23:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     Brendan Trotter <btrotter@gmail.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>
References: <20220329174057.GA17778@srcf.ucam.org>
 <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
 <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/7/22 23:36, Brendan Trotter wrote:
> Hi,
> 
> On Thu, Jul 7, 2022 at 7:18 PM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>> On 7/5/22 20:03, Brendan Trotter wrote:
>> Greetings!
>>
>> Not sure why I got dropped from distro, but no worries.
>>
>>> On Wed, Jul 6, 2022 at 4:52 AM Daniel P. Smith
>>> <dpsmith@apertussolutions.com> wrote:
>>>> On 6/10/22 12:40, Ard Biesheuvel wrote:> On Thu, 19 May 2022 at 22:59,
>>>> To help provide clarity, consider the following flows for comparison,
>>>>
>>>> Normal/existing efi-stub:
>>>>    EFI -> efi-stub -> head_64.S
>>>>
>>>> Proposed secure launch:
>>>>    EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S
>>>
>>> For more clarity; the entire point is to ensure that the kernel only
>>> has to trust itself and the CPU/TPM hardware (and does not have to
>>> trust a potentially malicious boot loader)..Any attempt to avoid a
>>> one-off solution for Linux is an attempt to weaken security.
>>
>> Please elaborate so I might understand how this entrypoint allows for
>> the kernel to only trust itself and the CPU/TPM.
> 
> Is this a serious request?

Yes, it was serious because I found the statements to be terse and open
to interpretation. Specifically, when I read it, it almost seemed that
the position is that dynamic launch is not needed, and that the kernel
could just establish its own RoT.

> Kernel is started (via. firmware using the kernel's efi-stub, or via.
> "kexec()", or..); and regardless of how the kernel was started the
> kernel establishes its own dynamic root of trust.(e.g. AMD"s SKINIT or
> Intel's TXT, followed by measuring the remainder of itself and
> anything passed from firmware like APCI tables) without relying on a
> call-back provided by "untrusted by kernel" third-parties that don't
> exist in most cases. The dynamic root of trust that kernel creates
> depends on the kernel, CPU, TPM, etc (and excludes untrusted and
> unnecessary third parties)..

This clarifies the previous statements and I would say, yes, this is one
approach. Considering the challenges we have/are facing in getting a
minimal post-launch handling (sl-stub) into the setup kernel, I would be
hard-pressed to believe adding all the pre-launch handling would be
found to be acceptable. If the intent is to have it completely
self-contained, this would require,
  1) the introduction of a TPM driver into the setup kernel, a hole I
     would rather not go down again
  2) potentially the ability to load files from disk if it is not
     acceptable for the bootloader to load the DCE (ACM/SLB)
  3) miscellaneous system evaluations, memory table, machine check, etc.

The only thing that is gained from such an approach is to make dynamic
launch for Linux be self-contained in the kernel. It does not reduce the
TCB because the whole design of the dynamic launch is to provide a
controlled process that establishes a new trust chain/TCB that is
started from an untrusted state. Specifically, dynamic launch starts
with the CPU being provided all the material for the process by
untrusted code that is currently in control at the time the launch is
initiated.

> The only potential benefit that the callback solution provides is that
> it, in theory, it could reduce duplication of work for other operating
> systems (FreeBSD, Solaris, Haiku, Fuchsia, .. could use the same
> callback instead of doing it themselves); but previous discussions
> (talk of formalising the contract between the boot stub and the Linux
> kernel) suggest that you aren't interested in any other OS.

With all due respect, but this is where I would have to disagree. There
is substantial benefit,
  1) a single code base that needs to be reviewed vs multiple OS
     specific versions
  2) establishes an API that decouples pre- and post-launch
  3) reduces the complexity required to enable adoption by an OS
  4) zero reduction in the security properties of the architecture

> This leaves me wondering what your true motivation is. Are you trying
> to benefit GRUB/Trenchboot (at the expense of security, end-user
> convenience, distro installer hassle, etc); or trying to manufacture
> scope for future man-in-the middle attacks (by promoting a solution
> that requires something between firmware and kernel)?

As a loyal member of the tinfoil hat brigade, I will always advocate for
accept nothing and question everything. All I can ask is to evaluate the
technical merit of the presentations [1][2][3] and the patch series [4].
If there is anything concerning with the theory or the implementation,
then it should be raised so that it may be addressed. A means to do so
is the "what if" game, as it is great to formulate a hypothesis. In this
case, the "what if" postulated is the assumption that the approach is to
allow a future MitM attack. Then the challenge is to examine the
process, their underlying mechanism, and the security properties of
those mechanisms to see if a MitM can be discerned. I will gladly engage
with anyone that presents an analysis demonstrating an assumption I
made/missed that opens the possibility for subversion of the launch
integrity attempting to be built.

[1] https://www.platformsecuritysummit.com/2018/speaker/smith/
[2]
https://events19.linuxfoundation.org/events/linux-security-summit-north-america-2019/program/schedule/
[3] https://lpc.events/event/7/contributions/739/
[4] https://lkml.org/lkml/2022/2/18/699

