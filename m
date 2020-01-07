Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05E1132DC3
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 18:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgAGR6c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 12:58:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33865 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgAGR6c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 12:58:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so507988qtz.1
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gq6F/16O7Va+a2/UACWvK3V1sRE8dV3z/aQWD1L6GpM=;
        b=Pr6OoiSJ5h8IZ3IASTNVc69XrtoYQw5a+85B3VHYZ8HkDcc/+KBTgg3xIw/dZXAFYw
         0XHyoGRB79xZsljMeB0DCX3WmYppYT+UXJDT9Jl97IECnzsz0tAePAu+ZI1mOmMGSwxF
         8NjrmbNP5r0Dpuaty2p33PBtl8KtT3wXWbv6i/c0ye2o8CAX8dOqX+a4Jt7LUx4DGLIG
         Zat1lqssYVvu8F5miKld2F3mwR8v2NK5f7DypKzJ+t6ntSmR/qNpCOV1eZQ/vp4NA4jy
         sLlZepMRlJx9dnWGY/OBdvFmVaP+WCA78QSxMCZ8zogH8fCeukvpVNqF3XSPFbq5rC2b
         EWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gq6F/16O7Va+a2/UACWvK3V1sRE8dV3z/aQWD1L6GpM=;
        b=NwkubD2Aq2pL8Gsp78MyRXoGnraHQ8r7dLCqPdD3VbECCKjIEhG21Wkg2rAowcZ8KW
         yMKMkI3dfZZrX8gn4YN/rZm4rRTX8Y5dH18j2Z89Te1Q75LSkmuuiod9phpcLly2B4ZS
         HSmzZzLY52RgIzygONbLq4WDBfDIP+y/KkRX/WX84sYukdpEQY3Fd+7kZV2Qj69aa0vi
         CzphTMPoEuiu4HZ31zETUESRjPpnAVGChWkoB5jZdFViO2ijDRrJQl+bQWAdAEZWMBXf
         dvpvHQtwRPCGnHPe+rKSgzv7IrAzTGP7D/4lyg5mM+niU0RlMNkQUCP/d2stGRt7dUIp
         zTEA==
X-Gm-Message-State: APjAAAUxTMo1bHcjMf5FySi9nuENnfE2gFCUnhdRdQTOZoVdlyLt9B/N
        epo91t3SY/SUAUibLTFkDttQClUY
X-Google-Smtp-Source: APXvYqxnWeliPKJfonrbt/aildUJ4TFmdmq6fjdxy+p5TxjWoThIA+vgPNsOnHmF9Ao7bPz1hu/XXw==
X-Received: by 2002:aed:3044:: with SMTP id 62mr146064qte.61.1578419911301;
        Tue, 07 Jan 2020 09:58:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r80sm133561qke.134.2020.01.07.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:58:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 12:58:29 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107175829.GA1599060@rani.riverdale.lan>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan>
 <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan>
 <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> 
> Unfortunately, the command line option implements a weaker form of
> visibility than the pragma, so it probably comes down to setting the
> pragma in a .h file that gets -include'd via the command line so it is
> guaranteed to be seen first.

Tried hacking that in and it works, tested with gcc 4.6.4.
