Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C539127661
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2019 08:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLTHRN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Dec 2019 02:17:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46186 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfLTHRN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Dec 2019 02:17:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id c22so10630542otj.13
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 23:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Cfg/jtIeTnMb4z4xGrc4rtX4fX6+Vq27trwXbPTunPA=;
        b=I3SPNz/oSRYtb1qJs6BIaUcnbfbFND0IiNyg+aiNanIyHoP8PTbghUrQoqBhi7ucLp
         xOvPqREM6gjqdVJdijUEUqoRS8R53O5od+SnPxPM/I0qywBGq+aqCC29EamyUJMyo42v
         SKyPYqME75EXVnt2EWXfYAk+tgjfTYHlCptO56leIwB3RXULvJiP3Es3ekb63iLeeMT8
         Gbl2swN6KljH3txaWPkt8/qjfFV8Ecn6zVapma0Wps2OagZNSKdI/IRInG0Oviwa9Kr8
         rSUcvOKSwfBw7wlVEjnNDZsCA9FWy3b7kU7IQ8bHW1WPoUfvmIWfDfPkY0VF7aVrSkLH
         p2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Cfg/jtIeTnMb4z4xGrc4rtX4fX6+Vq27trwXbPTunPA=;
        b=hvPRrVmTnzuAmQiLgw5e9amqYvfFUfmzvKLo5N39sslqQ2B1jX4nS6+MvHt/nL9ymS
         tImn4RpyIoSg87V2k4N3c9ln3AgcDeLdm4x0KPZNyWTqzBqLsRRk08CjB0UebvCw6tGH
         2wAe3LLeO6lbNRQBiv5WWxDtUfM2lxKySSbqxed+agKmZ6tsz+v8Nb4UAJjTrkKWdmp8
         rEjVU7btv65VDV3+/0L862GdgCVNj8XAsf1a4aJeqj8JH0Uc2ZSsrpDBCIPslvqNOCjq
         08rkTWyOXhG32pT2GgicysYLQdeVvLLtYjX2nVE8qY+92zKFFM4rXKDsHgIvSkAfPTcd
         D+mA==
X-Gm-Message-State: APjAAAUPe1sfLrf1ExwrD/xQx6YIHiV0jYxbOmH6FIPtc889uz4UhW7l
        /pQu/8Agsg2cDGuF/MRQf6v0Hw==
X-Google-Smtp-Source: APXvYqxmhXszp83D2wd/o+bOxp6oTMFuu0+8sbIbQeG4n5DQtmaS2994OD4CtoEhTsn3m9DOItoh5A==
X-Received: by 2002:a9d:774e:: with SMTP id t14mr13221002otl.358.1576826232256;
        Thu, 19 Dec 2019 23:17:12 -0800 (PST)
Received: from [26.82.234.166] ([172.58.110.182])
        by smtp.gmail.com with ESMTPSA id e17sm3127268otq.58.2019.12.19.23.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 23:17:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges during boot
Date:   Fri, 20 Dec 2019 15:17:07 +0800
Message-Id: <F25F57AE-15C5-4240-99D6-F6C93CFDA447@amacapital.net>
References: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
In-Reply-To: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 20, 2019, at 3:07 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> =EF=BB=BFOn Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google.com> w=
rote:
>>=20
>>> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>> +       status =3D efi_call_early(create_event, EVT_SIGNAL_EXIT_BOOT_SER=
VICES,
>>> +                               TPL_CALLBACK, handle_exit_boot_services_=
event,
>>> +                               NULL, &exit_boot_services_event);
>>> +       if (status !=3D EFI_SUCCESS) {
>>> +               pr_efi_err("Failed to register for EBS() event\n");
>>> +               goto free_handle;
>>> +       }
>>=20
>> OVMF's SEV implementation appears to tear down AMD's IOMMU mappings at
>> EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happens
>> first?
>=20
> It doesn't, and that is kind of the point. The only guarantee you have
> is that this runs before ExitBootServices() returns, but after any
> other callbacks that have been registered. I know this is not 100%
> what you're after, but it is the only way we can avoid poking devices
> behind the backs of their drivers.
>=20

Can you clarify (in the changelog or a comment perhaps) why you=E2=80=99re d=
oing this instead of turning off busmastering before calling ExitBootService=
s()?  Maybe this was covered in this thread, but I missed it.

Also, surely this whole mess is a a design error in EFI, at least when SEV i=
s involved, and there should be an EFI extension to keep IOMMU enabled.  Or a=
 specified way to *guarantee* that DMA is off when we exit boot services wit=
hout hackery.=
