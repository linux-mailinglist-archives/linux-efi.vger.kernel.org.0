Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C0B1793E4
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgCDPrs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgCDPrs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 10:47:48 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59F2215A4
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583336868;
        bh=f2zxh8G5/PluGbSKBsmaWoGRc8nqKWvdgyQhhQS7a4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vpiqGui5BfnLnr6xPgBCZI8TP/xts5SKofEFsTfrnMsVlJJlj7ezagg+FlVctO2+W
         twsQBtpz4iSEWV1irL6O2VEkGikGcggq8BWDL743rhYRJaedrSdRO9ED/XpEWQbs1P
         F6MsHFjKUPjODEuE+p00dR2BVlonPX2cjzri7G+M=
Received: by mail-wm1-f47.google.com with SMTP id e26so2361167wme.5
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 07:47:47 -0800 (PST)
X-Gm-Message-State: ANhLgQ3+Q/okUbCztm/gQ62g/sBo8oLqjUPvNestsL1g4O2SptOEEsQY
        nqxDXKN/TlkDq8xWiuiQ+foMfCGYcnzGbiOvlI+J+Q==
X-Google-Smtp-Source: ADFU+vsKLArrnWLQWlJtThuyVjaDKydGp3LxQaX8YxYSSWircwbsYCwj0DxXHJbefFDS6o2wYY4dpE66c1YI/mAZhl8=
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr4128059wmm.40.1583336866226;
 Wed, 04 Mar 2020 07:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20200303085528.27658-1-vdronov@redhat.com> <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <925307051.13073500.1583336716147.JavaMail.zimbra@redhat.com>
In-Reply-To: <925307051.13073500.1583336716147.JavaMail.zimbra@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 16:47:34 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9pDiaOUipnH_=YmWNUo+G4V_HxL6rzXML0hih4yetN8w@mail.gmail.com>
Message-ID: <CAKv+Gu9pDiaOUipnH_=YmWNUo+G4V_HxL6rzXML0hih4yetN8w@mail.gmail.com>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 16:45, Vladis Dronov <vdronov@redhat.com> wrote:
>
> Hello, Ard,
>
> > Wouldn't it be easier to pass a var_data_size stack variable into
> > efivar_entry_get(), and only update the value in 'var' if it is <=
> > 1024?
>
> I have prepared a v2 patch with an approach you suggest and will send it
> out shortly. It indeed simpler and fixes only the overflow bug mentioned.
>
> Could you, please, review it and if you like it, probably, accept it?
> In case I've implemented your idea incorrectly, could you, please,
> correct me?
>

Absolutely! Thanks for taking the time to fix these bugs, your
contributions are most welcome (and apologies if my responses
suggested otherwise)
