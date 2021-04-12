Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF69435B83F
	for <lists+linux-efi@lfdr.de>; Mon, 12 Apr 2021 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhDLBtc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 11 Apr 2021 21:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhDLBtb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 11 Apr 2021 21:49:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491EC061574
        for <linux-efi@vger.kernel.org>; Sun, 11 Apr 2021 18:49:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a85so7738260pfa.0
        for <linux-efi@vger.kernel.org>; Sun, 11 Apr 2021 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Vx2KQTnLK3al2yfhhN6ogkEgK5kENoQTKB4BS6xt9Iw=;
        b=UDG6qh1ioco1tYAQOYpjnqOan+6NEdL/1YJpbtmCg7KO/H/2huNEGIAvDf23QgMIBl
         yUpMH+0OmZUPVJuwciSzWbzd+GhR+kH95QTj+36I6WgwVNSY75/8xzpdST9mtzP2hl5f
         5elkOMX1iZjJfuKbMgIRXM0ay0J1cZJaI/w11J5QrXv5YD8nNMFXAsR2gXe1cSsQ2UQr
         JyS02daSedkJo/sy2GI3lx3vhfC4UFWXu3g8NXNQGJQIZq+URKCFyhN2NHDf1+sRRHN+
         f7YA7KXuT+YYUBvBnUxpPm8HoulrgGKhrCeDzVK/q9a2hN0tSAmALNZSIcrSRiV5KdZA
         Ye5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Vx2KQTnLK3al2yfhhN6ogkEgK5kENoQTKB4BS6xt9Iw=;
        b=URYbD0QrbXS8+n6k2H1zKbVm116np+/IBtR2lw57C/2NTDuDCOT311UTHQMusYmGQd
         v0N+v0rqaG3eE3lH6NGdlj69RXECPgOc1R8GUz1AS//f2CYMBVRSMz7v8wttYAYhnedL
         t4CfI2e/TN7QIMv5Cps6/NFzUFM3OeSnGQzPmsvzOCcoTDjRjsBCPFW5KhiTH2+ZbBcS
         idpO68fwzbP7OkTJdYwFuMMk1Ql59/C2BAznCvW6jlRy1j69F58UrfsT7NEuZhgf0Bpk
         q2YuwXZqZx8BcZ9E2bGjAwjDGO5JDWpUpsK0cx15th/8XdL0NB2SADlAWZ1n83/kWSGY
         NsFA==
X-Gm-Message-State: AOAM533sy2a8UnPKUS4tocyD14u7RyTXGDK6GrozOKd1Gv2KYnOsiZJn
        aGqJdnHiV4kSdUaxstUi4Wddcg==
X-Google-Smtp-Source: ABdhPJwbPffnN0R/YbOc+DY5BwpW0VBX8IyoF/86vbs1qbJ6RnrwvY8ACPoHJzPRt/1V/pI79+XrmQ==
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr24009932pga.203.1618192154547;
        Sun, 11 Apr 2021 18:49:14 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3129:54c1:fe68:a222? ([2601:646:c200:1ef2:3129:54c1:fe68:a222])
        by smtp.gmail.com with ESMTPSA id v11sm9459957pgg.68.2021.04.11.18.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 18:49:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the crashkernel option is specified
Date:   Sun, 11 Apr 2021 18:49:12 -0700
Message-Id: <8FAA2A0E-0A09-4308-B936-CDD2C0568BAE@amacapital.net>
References: <20210412011347.GA4282@MiWiFi-R3L-srv>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dvhart@infradead.org, andy@infradead.org,
        kexec@lists.infradead.org, dyoung@redhat.com
In-Reply-To: <20210412011347.GA4282@MiWiFi-R3L-srv>
To:     Baoquan He <bhe@redhat.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Apr 11, 2021, at 6:14 PM, Baoquan He <bhe@redhat.com> wrote:
>=20
> =EF=BB=BFOn 04/09/21 at 07:59pm, H. Peter Anvin wrote:
>> Why don't we do this unconditionally? At the very best we gain half a meg=
abyte of memory (except the trampoline, which has to live there, but it is o=
nly a few kilobytes.)
>=20
> This is a great suggestion, thanks. I think we can fix it in this way to
> make code simpler. Then the specific caring of real mode in
> efi_free_boot_services() can be removed too.
>=20

This whole situation makes me think that the code is buggy before and buggy a=
fter.

The issue here (I think) is that various pieces of code want to reserve spec=
ific pieces of otherwise-available low memory for their own nefarious uses. I=
 don=E2=80=99t know *why* crash kernel needs this, but that doesn=E2=80=99t m=
atter too much.

I propose that the right solution is to give low-memory-reserving code paths=
 two chances to do what they need: once at the very beginning and once after=
 EFI boot services are freed.

Alternatively, just reserve *all* otherwise unused sub 1M memory up front, t=
hen release it right after releasing boot services, and then invoke the spec=
ial cases exactly once.

In either case, the result is that the crashkernel mess gets unified with th=
e trampoline mess.  One way the result is called twice and needs to be more c=
areful, and the other way it=E2=80=99s called only once.

Just skipping freeing boot services seems wrong.  It doesn=E2=80=99t unmap b=
oot services, and skipping that is incorrect, I think. And it seems to resul=
t in a bogus memory map in which the system thinks that some crashkernel mem=
ory is EFI memory instead.

Let=E2=80=99s please just fix the problem instead of papering over it with m=
ore hacks.

> Thanks
> Baoquan
>=20
