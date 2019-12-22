Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF98128DF2
	for <lists+linux-efi@lfdr.de>; Sun, 22 Dec 2019 13:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVMqi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Dec 2019 07:46:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33415 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLVMqi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Dec 2019 07:46:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so7802897pfk.0
        for <linux-efi@vger.kernel.org>; Sun, 22 Dec 2019 04:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=usbIkiSPE2CSUoY7auB3WxRo2iVReGVoXG+VEFpostM=;
        b=q5PKffo54AXsidJuqp7OFrxRTz557IdAhgnG2dLTTJBCCdKp0w6J52tTo5x0txQ1DI
         FAPTl0Hzw79k+FKK25FUy2/IWUABL5eeuI8mdg+4hhgefKfKgXCa6D5K1tpr042ZA+gv
         dUfKVIMUcWLi9OpkwRl5j08CQimC/DcF98cD7nkbcqtvAhX0z5gy02eplzDrP4iraN0F
         qi4ngEPZ4hUglTE4dGY3s6FoM1WEi/ERIixndGobpdy6GSJqMDgZ0/UnZSb0rNVyQh6t
         jmMANJWVCto+1T8KiBsr3jjQS4wt3wXhDKQq+JUQwaXshDc7o7MFh/9lIl6jr6OtHc5W
         B5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=usbIkiSPE2CSUoY7auB3WxRo2iVReGVoXG+VEFpostM=;
        b=MLuHqfUhcuJ4+YpXoRaw+pncD19Ch5tEhcu3YAig5Uuk6GTLl2ekazN+o/Z5ZvjoWj
         617BuncsWArNfVl7RYOVjUFNS4B+w4lH5Hd9dl2uSKsUU/aNUJqXsQIuyb38mq0i09m3
         qJWfmRF3E48gMg6qipxg/VR64Hh3l8qQvmUMGoapBRFWpf9lMXbNc/gwq5CZDDoRKJs+
         VExqmQ4QHJEYRKTC9e3fCT3u4/f/MxgctKxXHaRyEL73K3oQfUxBw2CkUhK7j0qTFauo
         jetf2FDmea2JDnhDNabMmh89cp3fIi5CObacw+ckggvK6NM+RDLmU9fVg8S0uJpgPrc0
         34Kg==
X-Gm-Message-State: APjAAAWQ7qhaW7anwLeaybz4BWS84WUF+j0uwtfLx/Lde75YC81zflYT
        xFVX0j7Pju6SK++zKKKjjAfAig==
X-Google-Smtp-Source: APXvYqxE9j3J9EnUVkEHplaVjvyqkAmXXXHugJP8SaBjZ2QuzUP6tCWvBoHUkwksZ0R4NStLUp3N0g==
X-Received: by 2002:aa7:9633:: with SMTP id r19mr28009498pfg.90.1577018797598;
        Sun, 22 Dec 2019 04:46:37 -0800 (PST)
Received: from [25.170.160.12] ([172.58.27.11])
        by smtp.gmail.com with ESMTPSA id 11sm20784995pfz.25.2019.12.22.04.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 04:46:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 10/21] efi/libstub/x86: avoid thunking for native firmware calls
Date:   Sun, 22 Dec 2019 20:46:32 +0800
Message-Id: <4FEC2A1B-91A5-4357-8594-8BC8BB3D02A4@amacapital.net>
References: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
In-Reply-To: <CAKv+Gu8gWLw5-LkKwU0reUcreLyC8s1hQSzrR__-myuHrdVr7Q@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 22, 2019, at 8:02 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> =EF=BB=BFOn Sat, 21 Dec 2019 at 22:22, Hans de Goede <hdegoede@redhat.com>=
 wrote:
>>=20
>> Hi Ard,
>>=20
>>> On 18-12-2019 18:01, Ard Biesheuvel wrote:
>>> We use special wrapper routines to invoke firmware services in the
>>> native case as well as the mixed mode case. For mixed mode, the need
>>> is obvious, but for the native cases, we can simply rely on the
>>> compiler to generate the indirect call, given that GCC now has
>>> support for the MS calling convention (and has had it for quite some
>>> time now). Note that on i386, the decompressor and the EFI stub are not
>>> built with -mregparm=3D3 like the rest of the i386 kernel, so we can
>>> safely allow the compiler to emit the indirect calls here as well.
>>>=20
>>> So drop all the wrappers and indirection, and switch to either native
>>> calls, or direct calls into the thunk routine for mixed mode.
>>>=20
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>=20
>> I'm afraid that this patch breaks the boot on one of my machines.
>>=20
>> Specifically this patch breaks my GDP pocket machine. This is a Cherry
>> Trail device with a 64 UEFI running a 64 bit kernel build.
>>=20
>> As soon as I cherry pick this patch into my personal 5.5.0-rc2 based
>> tree, the GPD pocket stops booting and it stop so early on that I get 0
>> debug output. I guess I could try adding a few pr_efi_err calls
>> and see if those still do something.
>>=20
>> I noticed that you have made some changes to this patch, I've
>> tried updating it to the version from your efistub-x86-cleanup-v3
>> branch, commit id a37d90a2c570a25926fd1645482cb9f3c1d042a0
>> and I have also cherry-picked the latest version of all preceding
>> commits, unfortunately even with the new version, the GPD pocket
>> still hangs at boot.
>>=20
>> Unfortunately the nature of this patch makes it hard to figure
>> out the root cause of this issue...
>>=20
>> I've also tried another Cherry Trail device with 64 bit UEFI and
>> that does not suffer from this problem.
>>=20
>=20
> Thanks Hans.
>=20
> There are a number of things that change in the way the calls are
> made, but the most obvious thing to check is whether the stack needs
> to be aligned, since that is no longer being done.
>=20
> If you have time to experiment a bit more, could you check whether
> doing 'and $~0xf %rsp' before 'call efi_main' in the .S stub code for
> x86_64 makes a difference?

Hmm. Most of the kernel is compiled with the stack alignment set to 8, and t=
here a lot of asm that makes no effort to preserve alignment beyond 8 bytes.=
  So if EFI calls need 16 byte alignment, you may need to do something speci=
al.

On new enough gcc (the versions that actually support the flags to set the a=
lignment to 8), maybe you can use function attributes, or maybe you can stic=
k a 16-byte-aligned local variable in functions that call EFI functions?  Th=
e latter would be rather fragile.=
