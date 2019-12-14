Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDC11F3B6
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 20:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLNTqb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 14:46:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46350 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNTqa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 14:46:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so1641608qke.13;
        Sat, 14 Dec 2019 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taLHS8JyLC+BenbNT7BxnrVrwoDPqQMtSy8lb0fixC0=;
        b=HVurpgad1QMZQN0+i58d659mAg2CARQfC7k6Yc2ns+gRiGEMv+w662w2XASNY+IBO0
         obJd8LRJkqjqAenPYRGZZnrote5+1rpMa9nHxa5DQTQueo+82hxsRVo3D8ANaRk75+si
         9G81TK6fBwZeIxbVZLaaDVMQFMw1OSEDE7VojohAI1kRpEMxwoAjJ/iZoijSrYueLjV/
         xxSmyZlzThT5yo90i1oUBwhSjiCKrqZgRIbTU1By6IEKtkODA/IlqX0o3/ICRpPQY6we
         EqbRu5FKQiNHdG+48YSA0nFN9mnHx6O3sBHSO2ttCAbzSWjn2TFOtqBKkswukr8sF+zT
         N6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=taLHS8JyLC+BenbNT7BxnrVrwoDPqQMtSy8lb0fixC0=;
        b=TftmVZc4oWBcZsk62txCrodD1Ioqgiy6GF8wy4/BaPYUl1YqnMSmH1FMPuKQGU2/9/
         sWtN+wPVrCMs9RKXhz85mj58tO+rNcMtssUMKZQNiZDVuwvE6zqs7iNjg2sehbVftAtz
         o2oNXuDM9kx+n7ZpPj2blPNjKkuL3JCIbWXJvgtYx7HPvbvGvLq4UB2+gD6Go7emD3zZ
         FdV+Vxxjt37L07R87K3ZsBedrVT3Dw4TxXXwiEOq/THmPds2OLHMyFkhLwWY9tNz1oDd
         4828ZrDA983abCtY1xCtYVSNvCnSLRPuZ2zyhKEOdKyAUPv2u4rjWRim2swv4aDdGqKV
         4RPQ==
X-Gm-Message-State: APjAAAVtEkh0MWgsIQqW7O1ZkbA8MEo1GlyYMwb1kUlhBZ5aCBCW+O7/
        8oYDsQRVL8mg+2/EJhwQfzg=
X-Google-Smtp-Source: APXvYqwQrs/JEOLTWQC8pQo+gOvB/pQ/X08MuDids0dmfojHeL4EZ/iAx1PIIZhPK+PosoSANVKCmw==
X-Received: by 2002:a37:2e47:: with SMTP id u68mr19395733qkh.485.1576352789530;
        Sat, 14 Dec 2019 11:46:29 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d25sm4837459qtm.67.2019.12.14.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 11:46:28 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 14:46:27 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
Message-ID: <20191214194626.GA140998@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214175735.22518-6-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> +
> +#define efi_table_attr(table, attr, instance) ({			\
> +	__typeof__(((table##_t *)0)->attr) __ret;			\
> +	if (efi_is_native()) {						\
> +		__ret = ((table##_t *)instance)->attr;			\
> +	} else {							\
> +		__typeof__(((table##_32_t *)0)->attr) at;		\
> +		at = (((table##_32_t *)(unsigned long)instance)->attr);	\
> +		__ret = (__typeof__(__ret))(unsigned long)at;		\
> +	}								\
> +	__ret;								\
> +})

The casting of `at' is appropriate if the attr is a pointer type which
needs to be zero-extended to 64-bit, but for other fields it is
unnecessary at best and possibly dangerous.  There are probably no
instances currently where it is called for a non-pointer field, but is
it possible to detect if the type is pointer and avoid the cast if not?
