Return-Path: <linux-efi+bounces-4528-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB36B1F728
	for <lists+linux-efi@lfdr.de>; Sun, 10 Aug 2025 01:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FEE3A2DC5
	for <lists+linux-efi@lfdr.de>; Sat,  9 Aug 2025 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82A24679F;
	Sat,  9 Aug 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3ho4kiw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED77186294;
	Sat,  9 Aug 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754780583; cv=none; b=FiMXCF8M/+CyASZkDUG+G0XnemQPtAbUQofbLkCVi9wLuQFszSA1IqfLvCKUje/FGdxPFRlVoWGqAsLJfis1O/p3gRYsj2APEtMbug1NxnEngRtAlZ4m2QHNWLqKhvpNJw6hjb9LbXuQify6+nU6AOEPDLhR2zzq2iMzY/S0nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754780583; c=relaxed/simple;
	bh=st/eweHiwV92mUXCvAGpIiPGkvX3rErOBfHnwy2GSps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1AOEGdLVJCZ5OQoH4VGADtZqqhhkOwMlhPRAcrpTF38jSL3QUqxqlJWgmyAuFpx5iwxK+5A4NSLSBDtiJPMiKzsVzPTpswpIXBfvmAeHRFGtEwZ213WxtNHLH5WosMwWpLt4seUfGoEtwBuONusEn8HrEkGRNnHS7ljI4746M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3ho4kiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7401C4CEF7;
	Sat,  9 Aug 2025 23:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754780582;
	bh=st/eweHiwV92mUXCvAGpIiPGkvX3rErOBfHnwy2GSps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J3ho4kiwrH7rHSL79nbnLEr8Fi7+3PMWKaPF++iz6+hi+MdR9KEEzcVlLj8ka0pf8
	 8ghHe6EwgDyqH/6MV9E7RSlM3Xis2bC0eXh7XcwncUYg4cyhRzZRzt4ng/01hji6ic
	 z65whu1Kmp7Ovfvwvh5erXF+18ebGI5bDc9aCuD93E8d9YhJshoNIwWGXbxU9QDWKF
	 T6zvn7zjM3jiH2oit4GZPg9RFmtdfjbbGuqabHV6PdIu87V7pgvTwqzOXruVNSYlSb
	 mHqfQnZ7Pc/teaw4LYKyETrSoV1BFexfdIKEwp7BhRQebwXFhy3xHesvJQdBdZXBTD
	 JafFkKw/Bf4iQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32e14ce168eso37200951fa.1;
        Sat, 09 Aug 2025 16:03:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5KeVL2w6VzdSiCBiLb0GBmu7Tgkwv2k1MZUMqnN2ixtBX4NbZajlDkF10sqh80e5+iaTEp/TLdxxoVT/Z@vger.kernel.org, AJvYcCXHvgNcIaDr5pKniLlw+Uwekrsizm6Go42VcA7K9vyEVTdl+5p1rbzHh4Fdx+PztHkKsFn+BjZBIA4=@vger.kernel.org, AJvYcCXuvTJk37s7WICGylZS3ReB4be66lT7Hy0Zo2z7uUzRLnNDfTfvaofD9wtuXYWYsEBGMHUaw0M9/suX@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKrgpsSjHRu9EpsEpyX7F9E6OzE9MoAsM7Ty45zt8sWUcXOSt
	zpMHZSnKz5aqeDxAk05u3QDHdHYN2lxhNwM6+ea42Pxrj/kslIMgwf2brAs9LeU6vpgux61FsRL
	+Q6vDOqaorhF72wfUu1TiZKY3p33cJdM=
X-Google-Smtp-Source: AGHT+IHacj93S4TAyJS2Y33dq5fDEf3fw3H8pVieqGYKOrts0lqIXyoZID+Z9tXd8YeI87NlNCl9WjBC2eK/6u6auvE=
X-Received: by 2002:a05:651c:3799:b0:32a:7270:5c29 with SMTP id
 38308e7fff4ca-333a213e262mr13218821fa.2.1754780581250; Sat, 09 Aug 2025
 16:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com> <20250714060843.4029171-6-ardb+git@google.com>
 <20250803010449df1f5cfb@mail.local>
In-Reply-To: <20250803010449df1f5cfb@mail.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 10 Aug 2025 09:02:49 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGQyLXwk9Bq24xhPPsB1nO9RcSkvh=0p8aNP=Q=Az8V7w@mail.gmail.com>
X-Gm-Features: Ac12FXyxSfM9EC_oe23LQ4fW6u1l84sRZB4iGnVNSBFl1E9opWCoKNhC-oXMcUQ
Message-ID: <CAMj1kXGQyLXwk9Bq24xhPPsB1nO9RcSkvh=0p8aNP=Q=Az8V7w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] efi-rtc: Remove wakeup functionality
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Aug 2025 at 11:05, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> Apart from the topic that should be "rtc: efi:...", I'm ready to apply
> this patch.
>

Thanks, please go ahead.

> On 14/07/2025 08:08:45+0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The EFI rtc driver is used by non-x86 architectures only, and exposes
> > the get/set wakeup time functionality provided by the underlying
> > platform. This is usually broken on most platforms, and not widely used
> > to begin with [if at all], so let's just remove it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/rtc/rtc-efi.c | 76 +-------------------
> >  1 file changed, 2 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> > index fa8bf82df948..b4f44999ef0f 100644
> > --- a/drivers/rtc/rtc-efi.c
> > +++ b/drivers/rtc/rtc-efi.c
> > @@ -112,48 +112,6 @@ convert_from_efi_time(efi_time_t *eft, struct rtc_time *wtime)
> >       return true;
> >  }
> >
> > -static int efi_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> > -{
> > -     efi_time_t eft;
> > -     efi_status_t status;
> > -
> > -     /*
> > -      * As of EFI v1.10, this call always returns an unsupported status
> > -      */
> > -     status = efi.get_wakeup_time((efi_bool_t *)&wkalrm->enabled,
> > -                                  (efi_bool_t *)&wkalrm->pending, &eft);
> > -
> > -     if (status != EFI_SUCCESS)
> > -             return -EINVAL;
> > -
> > -     if (!convert_from_efi_time(&eft, &wkalrm->time))
> > -             return -EIO;
> > -
> > -     return rtc_valid_tm(&wkalrm->time);
> > -}
> > -
> > -static int efi_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> > -{
> > -     efi_time_t eft;
> > -     efi_status_t status;
> > -
> > -     convert_to_efi_time(&wkalrm->time, &eft);
> > -
> > -     /*
> > -      * XXX Fixme:
> > -      * As of EFI 0.92 with the firmware I have on my
> > -      * machine this call does not seem to work quite
> > -      * right
> > -      *
> > -      * As of v1.10, this call always returns an unsupported status
> > -      */
> > -     status = efi.set_wakeup_time((efi_bool_t)wkalrm->enabled, &eft);
> > -
> > -     dev_warn(dev, "write status is %d\n", (int)status);
> > -
> > -     return status == EFI_SUCCESS ? 0 : -EINVAL;
> > -}
> > -
> >  static int efi_read_time(struct device *dev, struct rtc_time *tm)
> >  {
> >       efi_status_t status;
> > @@ -188,17 +146,13 @@ static int efi_set_time(struct device *dev, struct rtc_time *tm)
> >
> >  static int efi_procfs(struct device *dev, struct seq_file *seq)
> >  {
> > -     efi_time_t        eft, alm;
> > +     efi_time_t        eft;
> >       efi_time_cap_t    cap;
> > -     efi_bool_t        enabled, pending;
> > -     struct rtc_device *rtc = dev_get_drvdata(dev);
> >
> >       memset(&eft, 0, sizeof(eft));
> > -     memset(&alm, 0, sizeof(alm));
> >       memset(&cap, 0, sizeof(cap));
> >
> >       efi.get_time(&eft, &cap);
> > -     efi.get_wakeup_time(&enabled, &pending, &alm);
> >
> >       seq_printf(seq,
> >                  "Time\t\t: %u:%u:%u.%09u\n"
> > @@ -214,26 +168,6 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
> >               /* XXX fixme: convert to string? */
> >               seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
> >
> > -     if (test_bit(RTC_FEATURE_ALARM, rtc->features)) {
> > -             seq_printf(seq,
> > -                        "Alarm Time\t: %u:%u:%u.%09u\n"
> > -                        "Alarm Date\t: %u-%u-%u\n"
> > -                        "Alarm Daylight\t: %u\n"
> > -                        "Enabled\t\t: %s\n"
> > -                        "Pending\t\t: %s\n",
> > -                        alm.hour, alm.minute, alm.second, alm.nanosecond,
> > -                        alm.year, alm.month, alm.day,
> > -                        alm.daylight,
> > -                        enabled == 1 ? "yes" : "no",
> > -                        pending == 1 ? "yes" : "no");
> > -
> > -             if (alm.timezone == EFI_UNSPECIFIED_TIMEZONE)
> > -                     seq_puts(seq, "Timezone\t: unspecified\n");
> > -             else
> > -                     /* XXX fixme: convert to string? */
> > -                     seq_printf(seq, "Timezone\t: %u\n", alm.timezone);
> > -     }
> > -
> >       /*
> >        * now prints the capabilities
> >        */
> > @@ -249,8 +183,6 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
> >  static const struct rtc_class_ops efi_rtc_ops = {
> >       .read_time      = efi_read_time,
> >       .set_time       = efi_set_time,
> > -     .read_alarm     = efi_read_alarm,
> > -     .set_alarm      = efi_set_alarm,
> >       .proc           = efi_procfs,
> >  };
> >
> > @@ -271,11 +203,7 @@ static int __init efi_rtc_probe(struct platform_device *dev)
> >       platform_set_drvdata(dev, rtc);
> >
> >       rtc->ops = &efi_rtc_ops;
> > -     clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
> > -     if (efi_rt_services_supported(EFI_RT_SUPPORTED_WAKEUP_SERVICES))
> > -             set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
> > -     else
> > -             clear_bit(RTC_FEATURE_ALARM, rtc->features);
> > +     clear_bit(RTC_FEATURE_ALARM, rtc->features);
> >
> >       device_init_wakeup(&dev->dev, true);
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

