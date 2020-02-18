Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7F1620EF
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2020 07:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgBRGdL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Feb 2020 01:33:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgBRGdL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Feb 2020 01:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=XOFRNTOKY2fXWXli+apjLPB1rzc4tFtyt/HpnYtWQUw=; b=LmoUjEIeFqoVcAcNq5dgaGJhQe
        xR7KWqis5SshsJOpvXFZew9AOhAy0b+mnGZZ0woT6azVFIDVK/YLkKda5+bbdk7IlI22HYhMTLHrD
        oQie4KgTMAtx7JS/+lxuHjJ8x1j/q4xcVx106SOJPa7uSYT2JCfCRZ2FmCXnGn66pxeUUc+TReLvG
        xkraicxFIkE91Wwy8aJ/ZSrCMpjX+us1u/iywm+ji0m1z8qEkUhIvTh0CkUtJSeqQnwejv9q6uxKi
        Fx+kmTEjZYVTB8DPHRLih/bQRcpb2isrllFxajnsjcPn5e2eGp5h59QybtVnPxeIsAWS2Z5gBNp/U
        FhDZOZ2A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3wRT-0006NX-B2; Tue, 18 Feb 2020 06:33:11 +0000
Subject: Re: [PATCH v3 1/1] efi/libstub: describe memory functions
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200218063038.3436-1-xypron.glpk@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <212145f2-5b00-fe82-82a8-360d3f608b35@infradead.org>
Date:   Mon, 17 Feb 2020 22:33:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218063038.3436-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/17/20 10:30 PM, Heinrich Schuchardt wrote:
> Provide descriptions of:
> 
> * efi_get_memory_map()
> * efi_low_alloc_above()
> * efi_free()
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v3:
> 	add missing colons for parameter descriptions
> v2:
> 	point out how efi_free() is rounding up the memory size
> ---
>  drivers/firmware/efi/libstub/mem.c | 36 ++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

