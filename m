Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB35129C9E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 03:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLXCPu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Dec 2019 21:15:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32977 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfLXCPu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Dec 2019 21:15:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so1057875wmd.0
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 18:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaE4kpF1OJYfTQ2Ue6cJFQHVS6FefG5r/SPgPvFpSlU=;
        b=WsPs4jeNy2qiMaTsckmPSpxWHkpqFM4tfUadrmW9iIjnCWorwxAyPqgUhpGkXAEiUz
         itgwWGOAuInlkK9TGZ7hBIQ4KOFSjSCX5fPob+YeTWEzxM8I1dF5WRn0BSCXPobnMJrs
         /ASWEv4QnXPjC0R15rDNkV9k5ahROZliB9nmDyFSFX8ydnr52TGSbOLvNYI118mRLogS
         0Ns2W574lcEsFzNqLsCfS3j0ZvYbR54fUBoH3jQIkyUlWwYyBTeEihykc495HcCEOd34
         iQZCkIBEi4lUcLRONFsKzgD0lWfPHJYJxX7uG4MK9o4kHj5xCk6wvUVKp9NX/5skukt3
         +gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaE4kpF1OJYfTQ2Ue6cJFQHVS6FefG5r/SPgPvFpSlU=;
        b=dSajkt7ExVHLzgpkfhgZipGRL1BzsN0OgPMrt+PuI9lzYTvcoxgiyHkclEnVtYSYSz
         UbQ+y1VbFvZtHJ9s84ca6g7ahSGx5XZruFmhWSIxn1vgn7kUYAvbBsv5ZCdb0Jfp2mef
         NIVUzfftIATLuTDXym2iJmg3UUkvy4Gxu1Cdz0Hzg3JDfIS80QA0Ao01ts8VBIn+vp40
         hJdgRsLcz1ke34SGypxzsIJDCRpeV3Br299NWwEOOuEyB92ZHokPcD2PM/nJAPBRpbK+
         BhcaFZeGRBciwZeyGxOne2oT+vvsb2NFb8ydRepFOmAcUCLXisB/sEnqfLsOTijw84oj
         Gk5Q==
X-Gm-Message-State: APjAAAXaLGeOiXhEyHMRLm/mXeiJdCXBwk/IFAwaoYPKeGRM4Jwe0ciN
        fEOiRPrtUbcFAsPfJtvbxccwAREQ/9437rPk+ZzrAw==
X-Google-Smtp-Source: APXvYqx3Ak6MEtQdwLTTnGSXQNp2BHZfcTvCPF3sBtewe1YkBukbmpm4Azs2es9I72UabMJhjsfVzpLr5KfpcUqmsPE=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr1587693wmg.38.1577153748473;
 Mon, 23 Dec 2019 18:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20191223152157.68545-1-ardb@kernel.org>
In-Reply-To: <20191223152157.68545-1-ardb@kernel.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 23 Dec 2019 18:15:35 -0800
Message-ID: <CALCETrXV1jbdvUMACdXiYuVyxxZUb1FByLPXLfwrooT-8N0Gpw@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: disable paging at mixed mode entry
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, X86 ML <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 23, 2019 at 7:23 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The EFI mixed mode entry code goes through the ordinary startup_32()
> routine before jumping into the kernel's EFI boot code in 64-bit
> mode. The 32-bit startup code must be entered with paging disabled,
> but this is not documented as a requirement for the EFI handover
> protocol, and so we should disable paging explicitly when entering
> the kernel from 32-bit EFI firmware.

Does this mean that EFI is allowed to call the kernel with paging on
but the text identity-mapped?  Have you seen this happen in practice?

If the kernel is entered with paging on and the text not
identity-mapped, this is going to blow up badly.

--Andy
