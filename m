Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37B2C2EA0
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390887AbgKXRdF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 12:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390791AbgKXRdF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 12:33:05 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BDD206F7;
        Tue, 24 Nov 2020 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606239184;
        bh=3edk/P+TSki7lqmQHf7lfC61UtOdi+d/ymZ/f3SXmKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IdXapJqSYv+TxTI1vd1Q5szmXdxi4D3e1G8QO7S4RC5PVbUMfFWFXicR966BI8xRY
         AXSbYcy8n6tKXcbjpfAIFq4dKtIXSKeeFAcdPbhBQcvV8Y8HvvrSyVvd/xa1ciRrUO
         EP4NHLfTwitwbUlliGVC7Gm8DyPlCzof2XV9bJXQ=
Received: by mail-oi1-f169.google.com with SMTP id h3so1080387oie.8;
        Tue, 24 Nov 2020 09:33:04 -0800 (PST)
X-Gm-Message-State: AOAM532zfAYWP3vS6Agadc+3ImnLe0JBXDP1VBrcRj+ri2doXFXi87IF
        46/UD7ND+9QVEkh/kP8f5j9N3UIhYpEkH2zBxQA=
X-Google-Smtp-Source: ABdhPJzz/FWGkiYxtnxUMLOPkCf0nLFXF4z0bduoCXU5Rvh/5Bvw1Axe3VZKmpPmAt9Kf9tbxBelsjeqFuk/g3xqYjU=
X-Received: by 2002:aca:c657:: with SMTP id w84mr3253782oif.47.1606239183818;
 Tue, 24 Nov 2020 09:33:03 -0800 (PST)
MIME-Version: 1.0
References: <cab88111-e8a8-5460-bf67-055d3562da10@molgen.mpg.de>
In-Reply-To: <cab88111-e8a8-5460-bf67-055d3562da10@molgen.mpg.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 18:32:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE08bux+ZJYjq4hCcs3LGRMUNZfJ65ip_f2HPd+fot=bg@mail.gmail.com>
Message-ID: <CAMj1kXE08bux+ZJYjq4hCcs3LGRMUNZfJ65ip_f2HPd+fot=bg@mail.gmail.com>
Subject: Re: What to do with `BERT: Error records from previous boot`?
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Nov 2020 at 17:24, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> On the Intel Tiger Lake Dell XPS 13 9310 Linux 5.9.9 from Debian
> sid/unstable logged the messages below. Please find the whole log in the
> Linux bug tracker [1].
>
> ```
> kernel: BERT: Error records from previous boot:
> kernel: [Hardware Error]: event severity: fatal
> kernel: [Hardware Error]:  Error 0, type: fatal
> kernel: [Hardware Error]:   section_type: Firmware Error Record Reference
> kernel: [Hardware Error]:   Firmware Error Record Type: SOC Firmware
> Error Record Type2
> kernel: [Hardware Error]:   Revision: 2
> kernel: [Hardware Error]:   Record Identifier:
> 8f87f311-c998-4d9e-a0c4-6065518c4f6d
> kernel: [Hardware Error]:   00000000: 0100a306 00000280 ca5824d3
> 000003ab  .........$X.....
> [=E2=80=A6]
> ```
>
> How can I decode that error to understand what happened?
>

Dell or Intel should be able to provide that information, although
getting them to do so may be difficult.


>
> Kind regards,
>
> Paul
>
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D210347
