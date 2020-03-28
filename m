Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4419671C
	for <lists+linux-efi@lfdr.de>; Sat, 28 Mar 2020 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgC1PoG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Mar 2020 11:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgC1PoF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Mar 2020 11:44:05 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442DD2073B;
        Sat, 28 Mar 2020 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585410245;
        bh=oPtAZwFBh/OxU8kNRsKrJfCQe/cMqc4fD2Xm6xmFz6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYsCVc40m3fNFDYPgQZ295VivE94MDcQLNdyCgV++gCpqNPjyRx6OvbUiV9H2D2Fk
         +15VqOdJCRFgaF3dyPyY7u7IdxKWSxmEQXAYmY1kTMD3ONkUJeFn8SytdfoWj9R87M
         bwWr7Edd+HheCvflYNv1djeAJvzEX1nz1zDYJ4Hs=
Received: by mail-io1-f49.google.com with SMTP id q128so12973468iof.9;
        Sat, 28 Mar 2020 08:44:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ02Xs2UmdChuD78sz9DiWDUxWQuMiSludS1BNomGL+I0vNNfuoh
        qFSlgu7KnocSKC0T2FrqYxKygTlRYzHl8km5jr4=
X-Google-Smtp-Source: ADFU+vupijrGqSmIQYuqjpeQO548BEQNMOSWnKWf75hqsLFbZOUqcrtsFemfR2n4urue3tQRVwQa17H8HCEgysKDWWk=
X-Received: by 2002:a05:6602:2439:: with SMTP id g25mr3602098iob.142.1585410244693;
 Sat, 28 Mar 2020 08:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200319192855.29876-1-nivedita@alum.mit.edu> <20200320020028.1936003-1-nivedita@alum.mit.edu>
 <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
 <20200325221007.GA290267@rani.riverdale.lan> <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
 <20200326235637.GA2364023@rani.riverdale.lan>
In-Reply-To: <20200326235637.GA2364023@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 28 Mar 2020 16:43:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3gVeDKBQxGcpb69DDSBU2DC1t1DDKYMRdx3nGWiLxEg@mail.gmail.com>
Message-ID: <CAMj1kXF3gVeDKBQxGcpb69DDSBU2DC1t1DDKYMRdx3nGWiLxEg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Mar 2020 at 00:56, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Mar 26, 2020 at 12:36:25AM +0100, Ard Biesheuvel wrote:
> >
> > Yes, -ffreestanding implies -fno-builtin, which means that the
> > compiler cannot assume it knows (and can optimize away) the behavior
> > of strlen(), memset(), etc.
>
> Yes exactly. Do you foresee any problems with removing it?
>

I'm not sure why it is there in the first place, but I wouldn't extend
huge issues when we remove it.
