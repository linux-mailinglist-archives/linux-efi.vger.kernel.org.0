Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04315D898
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2020 14:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBNNfz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Feb 2020 08:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgBNNfz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Feb 2020 08:35:55 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFB724649
        for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2020 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581687354;
        bh=0vY6bZRW9DfKzgWF9cI5MYmn/9oq1WhqbhXQgBX9WiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z9khEmHG/1uqm6+YaDyBzrstAiGeF7befsbKxZKQQkaLQ+klk+Oxzg9hSQE6MtPWY
         ZELXkzyJkkMp/ntBQSIp79e+cGlw99Zi9zpGp1HhMqAWawMF0/Tuv1ksimMC6Wg8q9
         e4DJ9G1iWuywRb4zp/UknxFUnwkuwMcuAkX01TM0=
Received: by mail-wr1-f46.google.com with SMTP id r11so10904449wrq.10
        for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2020 05:35:54 -0800 (PST)
X-Gm-Message-State: APjAAAUOd83Klc+UJIllrKIkNeYZANlErCOXANrTSCol9jOpd4kJAosf
        hnCxLGqV/aq/gSOlZnmFdJ8luM+HcEuFWN4KQgJA3w==
X-Google-Smtp-Source: APXvYqwlSmUpx5BeG1bSvsqNBXOGUCynyGmxqQ/uZ/coUsGhDeLcb+DaKKoeR6yiaS3ZaTdKf9rb3xsj50wgeRRBWNM=
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr4107266wrw.262.1581687352791;
 Fri, 14 Feb 2020 05:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20200213102102.30170-1-ardb@kernel.org> <20200213102102.30170-2-ardb@kernel.org>
 <116eb62a-8067-b4f1-171a-2659bcaa94bf@redhat.com>
In-Reply-To: <116eb62a-8067-b4f1-171a-2659bcaa94bf@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Feb 2020 13:35:41 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu8Fw=jbaoC4+6Cc2ySHAa5z_ku7-BhHTQjHW58XSP46ww@mail.gmail.com>
Message-ID: <CAKv+Gu8Fw=jbaoC4+6Cc2ySHAa5z_ku7-BhHTQjHW58XSP46ww@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/x86: align GUIDs to their size in the mixed mode
 runtime wrapper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 Feb 2020 at 13:55, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/13/20 11:21 AM, Ard Biesheuvel wrote:
> > The mixed mode runtime wrappers are fragile when it comes to how the
> > memory referred to by its pointer arguments are laid out in memory,
> > due to the fact that it translates these addresses to physical addresses
> > that the runtime services can dereference when running in 1:1 mode.
> >
> > As a quick (i.e., backportable) fix, copy GUID pointer arguments to
> > the local stack into a buffer that is naturally aligned to its size,
> > so that is guaranteed to cover only one physical page.
> >
> > Note that on x86, we cannot rely on the stack pointer being aligned
> > the way the compiler expects, so we need to allocate an 8-byte aligned
> > buffer of sufficient size, and copy the GUID into that buffer at an
> > offset that is aligned to 16 bytes.
> >
> > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I can confirm that this fixes the WARN_ON triggering I was seeing,
> thanks:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
>

Thanks Hans

I'll let these soak a bit in efi/urgent before I send them to tip.
