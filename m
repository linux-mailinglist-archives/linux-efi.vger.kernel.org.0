Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4315C900
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgBMQ7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 11:59:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41019 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBMQ7H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 11:59:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so4871240qtr.8
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxuTUtjBiIkjeRmpGcLiElYNN3iiTYBT8TjHqmzGtI0=;
        b=NyQPoKzqtqUDFe+ZVb6FHLXTwwhC6+d/tmy9HQ6WBNV1pd/7kePTPEY5UINrubC/kz
         yko21GagFbscLXe293Z380uw3og5/W0DL67OxyrAgXF4T9DK6cAaG4ryrSzDFFsmLq5J
         m2pvFb990WTHTlhZCDr1nanOWm0wsj2udpcK8akKO1wT9l+f557mPGta4mbby9jjQqWx
         NJfmdwxhdBVuOdZOKN3k602N2A7BwFC8/agZeB1m+nS/MbpuGSTY2lGUu6BLXXLuyxv/
         BTwRqFCrkpbiBOEB8Fns9PC0tf4vK5HtHbUyuRHoYxuMn+wCPVWtplNgujWGjX+6sAeV
         rVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxuTUtjBiIkjeRmpGcLiElYNN3iiTYBT8TjHqmzGtI0=;
        b=gV+PPmCCU8gCuh0kKVfy99TtXBSSRNwOeewqHnUqBQ+VLLCT0h4IIMhX4k2qNugR6B
         0bXs5pCrCooYNY8Leo2Eb3GTEOtVJXFN7Ua8exoTLI2Dts9FnyJbwSKNL+cqw2HL5WE1
         i/hHSzdu/JZ6DB3wlDijsxQLtweY/XQZeGfHe6GQl534pnKWoDglMnmUwc+v5vY+aUkC
         yqx4moSJ85rY6cYdts85lPYFLrGw8a3k+pYJoAajnQqMKtcv8M6IWWDM5oj33IT2yWb9
         uQayCmQCeM927Du2sAQ7eZC/DlFKf1zmXE9GGA68+w2gwUjonDeeZdd6a64aJl1+xEIv
         KsCQ==
X-Gm-Message-State: APjAAAXjtEkLdUtfoyOC8SQxkZDyp/Pkh942igicYlZGiJ3Sb+utQ3aQ
        B9LuTwmNl4NQMfpFDR4OnsRoFAnmzrQ=
X-Google-Smtp-Source: APXvYqx2ev5Iw2z0kE6/Iwqq/1SbJGW3fueGe2tlmP2uK0MXbbqj2zOewIHPEqKXFVWKv1NIWgo3IQ==
X-Received: by 2002:aed:3e13:: with SMTP id l19mr12210232qtf.103.1581613145573;
        Thu, 13 Feb 2020 08:59:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u12sm1808979qtj.84.2020.02.13.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:59:05 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Feb 2020 11:59:03 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, daniel.kiper@oracle.com,
        hdegoede@redhat.com, nivedita@alum.mit.edu,
        mbrown@fensystems.co.uk, mingo@kernel.org
Subject: Re: [RFC PATCH 2/3] efi/x86: add true mixed mode entry point into
 .compat section
Message-ID: <20200213165902.GA1400002@rani.riverdale.lan>
References: <20200213145928.7047-1-ardb@kernel.org>
 <20200213145928.7047-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213145928.7047-3-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 13, 2020 at 03:59:27PM +0100, Ard Biesheuvel wrote:
> Currently, mixed mode is closely tied to the EFI handover protocol
> and relies on intimate knowledge of the bootparams structure, setup
> header etc, all of which are rather byzantine and entirely specific
> to x86.
> 
> Even though no other EFI supported architectures are currently known
> that could support something like mixed mode, it makes sense to
> abstract a bit from this, and make it part of a generic Linux on EFI
> boot protocol.
> 
> To that end, add a .compat section to the mixed mode binary, and populate
> it with the PE machine type and entry point address, allowing firmware
> implementations to match it to their native machine type, and invoke
> non-native binaries using a secondary entry point.

This patch refers to efi32_pe_entry which is only defined in the next
one.
