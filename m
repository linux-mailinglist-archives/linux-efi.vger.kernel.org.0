Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D098FAA9
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2019 08:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfHPGOZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Aug 2019 02:14:25 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:38219 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfHPGOZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Aug 2019 02:14:25 -0400
Received: by mail-qk1-f181.google.com with SMTP id u190so3887243qkh.5
        for <linux-efi@vger.kernel.org>; Thu, 15 Aug 2019 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Wobw7RLI2u4sURUplFIazpvMFVTZ4ZldULV2wWwAjLI=;
        b=P4PXZlqO4bxMmgCyUAeKyZuva2t09lb4gxM5F8Q0TKniiDkPZTPU32iqrasU5PqA/a
         sW2xn5dzUQ71EcV5yfF1DyaBAdl6lAW9Bou+RkVhIUmg9TmtJzTHmqiPyB7G5DYs1h7b
         YUC10afZhajanSIqc9W3qHXPw/dW/RLASzmtPSftnDHtlyqGg5grYTttdS4tJ6hdtl/D
         dZEIly9IrYBDxb4HgNC9quaeXrPMutp4gWJbKCsCIVxvXHjEoLI5D0z+7K1OVdPneRcS
         YXFWIFQ4vVO+TNdkTcZ5UTuiFHaGx2rYOtnWfIq9SueukdChWLqNNn9PNHUzRMicxCVO
         kslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Wobw7RLI2u4sURUplFIazpvMFVTZ4ZldULV2wWwAjLI=;
        b=mgtbqSRL2owNuNvxP7+m5NJf7dpUkGrKATKP4P/V42hmlklIHtYfBNm095hzqlaaEd
         O3W/uDdaFHGX1QB3oPkan7XvgnOMyuInOzGALBMbSjUB33jdn1TQXAzYl4/QIqV+5K53
         u39f75hLdSQg2khGOcgOtBMh8sRoLYX4RNojN4zYdJc8uvJoLh+MK9iLqQOBK/R8m66N
         N1mgxZClQTiCBoPC/4rbUyn7nONGWmf52Br/QScYN0Uy9FJLhaXr2CtKZw1EdlwBsWTV
         x/lDva0uXO8RruAvju6DvJjk3UOA4/nD0nCz/SEhvtu2MA4xdUlocTAJ7TFl8fQZtPHl
         hwqQ==
X-Gm-Message-State: APjAAAUReSjGMzYru1FGmwTppKE28rVpTgrQncudhANKLyPX6H5aiEn7
        Twy47Flz3s4bxhSqKY1AQzKEdTNPYGkFvlPE+yR127G/qjgaiA==
X-Google-Smtp-Source: APXvYqyuJN4EamXDadrwWcQZXuetXYRpSbmWUVT+dioEJ0gfzkoad2f8wXkuGYI+/W9UnV8bqDO3G0Yxfyspv9usdhg=
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr7200498qkg.478.1565936064063;
 Thu, 15 Aug 2019 23:14:24 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 16 Aug 2019 14:14:12 +0800
Message-ID: <CAD8Lp47V5G+3UfEzt9wNRr7U-RdLAdCO7JFLQ+QF1JbkuhCcPg@mail.gmail.com>
Subject: Early EFI-related boot freeze in parse_setup_data()
To:     linux-efi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

We're working with a new consumer MiniPC based on AMD E1-7010.

It fails to boot Linux when booting in EFI mode - it hangs with
nothing on screen. earlycon=efifb doesn't show any output.

Looking closer, I was able to confirm that we reach EFI
ExitBootServices() via efi_printk in the efi stub. But you can't use
EFI's console functionality after that point, so I then resorted to
inserting calls to:

   idt_invalidate(NULL); __asm__ __volatile__("int3");

throughout the early boot code that follows in order to force a system
reset. That way I could deduce if execution was reaching that point
(system reset) or not (system hang as before). As a side-question I'd
be curious if there is any better way to debug such early boot
failures on consumer x86 hardware without a serial port...

Anyway, the system freeze occurs in parse_setup_data(), specifically:

        data = early_memremap(pa_data, sizeof(*data));
        data_len = data->len + sizeof(struct setup_data);

Dereferencing data->len causes the system to hang. I presume it
triggers an exception handler due to some kind of invalid memory
access.

By returning early in that function, boot continues basically fine. So
I could then log the details: pa_data has value 0x892bb018 and
early_memremap returns address 0xffffffffff200018. Accessing just a
single byte at that address causes the system hang.

This original pa_data value (from boot_params.hdr.setup_data) was set
by the EFI stub in setup_efi_pci(). I confirmed that the same
0x892bb018 value is set there, it is not being corrupted along the
way.

Any suggestions for how to diagnose further?

dmesg output:
https://gist.github.com/dsd/199bed7b590e90efdf73f9f6384ca551

Thanks
Daniel
