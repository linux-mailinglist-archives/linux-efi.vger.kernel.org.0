Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFB39114084
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfLEMGf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 07:06:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53706 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfLEMGe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 07:06:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id n9so2934912wmd.3
        for <linux-efi@vger.kernel.org>; Thu, 05 Dec 2019 04:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/JXqQuIVvELZvtbxu4JQIb34IcftH1RWqiFbYiSOGw=;
        b=z7ZjjcPlFZoSP8s8Yid633QhPgkfMoMug2fZdoYMvesbPo3kL6yFewLz4cK2hZaKR1
         YN4IckKVBnOw2Q/bomnvNdOfi3PKL0DT7dhn3PSSB+ICCQnPjsz6ZKQ/ln+Ewr9NOid3
         J3CdYJ0zR315TO4mYgv39UV9JYI466S0ZEVdISdK+FhnqaH/ENC7mim00IcwMlZDxnbT
         UWA+GscY34vcPDXwG5nVYRVcp74AXSbcYeEjV/AUhfS148C+c4UhBmjvjW8hm+mkRNlu
         vVL5lTkydSeNEDs6y+kD2luk2dL+HLnJT1mpKDCpZPbYgHcT0pB8KktIcvYzb20RwDpj
         HxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/JXqQuIVvELZvtbxu4JQIb34IcftH1RWqiFbYiSOGw=;
        b=rgThpBX6RmV/MiyxGSDJm7auW8e7CCXWaPH1kgfOWSV12uYdFSY9FLFqDtZCx6jVdm
         z9Wvj/eJ6lmq7H8oZQusFem9mp0+0KRkJTUBmuYHsqr9VF6ITbUMwD4Y8Y7WhKiEh5fC
         QdwxoyW9IoXsP6TBq7YC55gacXMiQ7nJVXDBn75wHTO4M9Yr+gNRJlHb6SCYaeahIXuS
         Kj6N4eqq6VaenXfXivN11vth0/E40sRG34o8N1EjxnXzmlE78sscQsK4xYeEp88I1581
         qwSvlXXUMMyOffC3p79ivbPQll3gAr5/9E39rWud3tJy+SIyZkP7gOoYv7xL+DQNnlWt
         rDxw==
X-Gm-Message-State: APjAAAU/OY/MSb38ARuQ+ZmkZqUoH6ZNk7/CZsxdtbBKWQ/yEDsRdoBH
        GWdMuCQuXPaQ7Itlm17bqKpmKTMoMfvLdPWEFLFOzA==
X-Google-Smtp-Source: APXvYqy85reIbZ8QXiZ/PEqNQKl+Demi4htlOfZitXwaMsbYicieDHPmFH1TCxMakhhkYilEksWoyssxFjQJiN9KySM=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr5016253wmc.9.1575547592616;
 Thu, 05 Dec 2019 04:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20191203214728.19264-1-nivedita@alum.mit.edu> <20191204181744.14326-1-nivedita@alum.mit.edu>
In-Reply-To: <20191204181744.14326-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 12:06:29 +0000
Message-ID: <CAKv+Gu-ihHLekCo-PKPNUSYko33_41wFeR716h9AtfS6KhzR3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix a couple of bugs in efi/gop.c
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Dec 2019 at 18:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Changes from v1:
> - Split return value patch into two as requested.
> - Remove the __gop_query functions
>
> Arvind Sankar (3):
>   efi/gop: Return EFI_NOT_FOUND if there are no usable GOP's
>   efi/gop: Return EFI_SUCCESS if a usable GOP was found
>   efi/gop: Fix memory leak from __gop_query32/64
>

Thanks Arvind

I queued your changes as fixes here:
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=urgent

I intend to send them out for inclusion in v5.5 in a week or so.


>  drivers/firmware/efi/libstub/gop.c | 76 +++++++-----------------------
>  1 file changed, 17 insertions(+), 59 deletions(-)
>
> --
> 2.23.0
>
