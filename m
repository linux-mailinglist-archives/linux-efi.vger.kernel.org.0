Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C262110556
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 20:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLCTlp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Dec 2019 14:41:45 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:33170 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfLCTlp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Dec 2019 14:41:45 -0500
Received: by mail-io1-f46.google.com with SMTP id j13so5198371ioe.0
        for <linux-efi@vger.kernel.org>; Tue, 03 Dec 2019 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBemf5DffbM9H45GJNpf6XQTgytqS7SHwtWxDozwP2k=;
        b=Zn6/mtS46CfYNTBvL+G3gsuGdj1yDZoKrME2Cm0wMQCY5fjcoWvefbN1CLMGjmOJA1
         9WC2PCtFU8/4Vfd86+YWCUQIvD9IOjXz34uyx/oizThOidMc1Rr0u0foU+ENh1eWzRRd
         6l8ow8Ls2e3YVJifDJ0mtA6n/3ev0jFO8JJ+Tetw55fE3BZW/65tDfu58DYHWpL900Hb
         z5JrdoFih7F7WjFZ6OB4c0Tm/Qbd8PQ3GaRoIQa9kfq1Db5dV1NprGktZwf6GGHsNcmE
         YGHLmKd1Je58e3wvoMtiPxTd4xKzZD57TXT4CL0ZVrlbTrU3JZaYltoYxGOJIFmjwp54
         a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBemf5DffbM9H45GJNpf6XQTgytqS7SHwtWxDozwP2k=;
        b=JE4nRyVVltZAWsNXQbvFh3W8dumy1/KsFriWIhHQz75NU5C+UXChVl7CgXc0Sc+jfr
         ZeJAyv4LfWHbKQU2nQevcp7t7lKFuC1mE1ZxjE01KZ9/fYqi9TWhZ6Iswch0l83wfG/0
         DdWvI19wBZXf+PyraL012JAJjIKCtYFaQ202496IJArfF2YPNB2OvvbsJKyhkR9WiLeD
         Day+cfdsNTRV5DBprq6mpLfZlGCBXmmePNWHdXWTYgbhPpv+cbr402cCIhlVJSNwzWwv
         y9shFTWKI7awVI6s3vq3D8zVdDa+8gsbeeAK+MDVl6dmCJJFrbsgJpN/pxrYAGb9D6/m
         8MXw==
X-Gm-Message-State: APjAAAWkHQH5FpQ5fphkqulB2Um9LZO9HaHx23zfSLX/eAYu3ICdPKNJ
        YKS6Fx4dju855yrSUMQHbLhqo/z12yw9NIRGC7nqJAI/D6Q=
X-Google-Smtp-Source: APXvYqwxkVJgS3InUv5/LmPbRiof3P9j+j9W7/spqafHaIbJnIhprxg1ULJPZZFP78UueZBNHl/exmw8VSDIniSdL/k=
X-Received: by 2002:a5d:9913:: with SMTP id x19mr3905793iol.46.1575402104183;
 Tue, 03 Dec 2019 11:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com> <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
In-Reply-To: <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 3 Dec 2019 11:41:32 -0800
Message-ID: <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 3, 2019 at 7:30 AM Andy Lutomirski <luto@amacapital.net> wrote:

> Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
> is busmastering on when the kernel is loaded?

It's only relevant where firmware configures the IOMMU but then
removes that configuration before handing control to the OS. I'm not
aware of that happening anywhere other than EFI.
