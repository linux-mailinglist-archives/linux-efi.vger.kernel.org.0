Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30AFC11FAC6
	for <lists+linux-efi@lfdr.de>; Sun, 15 Dec 2019 20:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOTbC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 Dec 2019 14:31:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46384 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOTbC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 15 Dec 2019 14:31:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id 38so3957562qtb.13;
        Sun, 15 Dec 2019 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjP8HELsIsX5By51jIuxfXXGXh1QbgEGgtOsuZGRL0M=;
        b=TQMgThpcoVuVJLZtkZShTFA/9wrwkFck9yI7Rv3ZjRD4Phf7BdW9xRjTrNPD4REwBm
         H6kiVGtYVDtWNR9Gv7MplIOBn9RZcOkTNIml0Vhsi52XdlL5S5rHGmJ7GKkGcge8/Cnx
         c/BDzNYvSk36kOGyatKY2PlsVAJrwGM08RxezNut+yzLcs6dTgkMmJ2hH++vMIgPck6j
         91oj18I2ylXSpyAXAfgO/0K99weOLV8qcrc+iNQ2wEoy0AzDMOEgYlJtz0Ri1121g+i6
         14RKnyHWMYIXxYCNW0XMTpM2fDxgJe8m2f2sizgQ2oyds90Sb0xQGagY3Y3HohSThVEp
         z1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjP8HELsIsX5By51jIuxfXXGXh1QbgEGgtOsuZGRL0M=;
        b=HXdx/PjdyADeIe1oRUT7fE41lI9EiVIugyByRbJZsw0Vqm1PNsQLHGu/m8Sw1bdau8
         3ltA+smhelg0taVADc29uTqF94fhRm9WQG4bzfp+vCshE5YVzxtYbkr1sy5qfYtnS3Ei
         u5eqvpeDT6qzrOzY6MKD+NLQZvv2z0225ZIExEphn9s4OouHU0GpS1bg0Q/MD4zQ7P2L
         z5yPiV2pfjtCo0yTf8/RSMjX3az63dHfTvQYHBD2WVz4IVOPti0b5+crHqos/ACTWEp6
         A055gj2Z3NESL9/SlFLU1p9mFd10SrvZAPncmosFsTIunW/CZXNkQsJio085SYB0mTl7
         AXpA==
X-Gm-Message-State: APjAAAVek9NRM6cgcb1MssMAOjv7/jVMbSLUNII/xBVjJ+U2r4cSMLFX
        6mi308vaxb28dFdSQSBUEvY=
X-Google-Smtp-Source: APXvYqy5wp9ETUh/e2UVGHP0aCkuLaRAj4hWy4GeKfE5NHGl0J2LOqkkOanUVmrVK+B7QNCbvuuZYg==
X-Received: by 2002:ac8:33a5:: with SMTP id c34mr21919830qtb.359.1576438261023;
        Sun, 15 Dec 2019 11:31:01 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q25sm5233756qkq.88.2019.12.15.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:31:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 15 Dec 2019 14:30:58 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 10/10] efi/libstub/x86: avoid thunking for native
 firmware calls
Message-ID: <20191215193054.GA2187004@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-11-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214175735.22518-11-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 06:57:35PM +0100, Ard Biesheuvel wrote:
>  
> @@ -232,7 +232,7 @@ static inline bool efi_is_native(void)
>  #define efi_table_attr(table, attr, instance) ({			\
>  	__typeof__(((table##_t *)0)->attr) __ret;			\
>  	if (efi_is_native()) {						\
> -		__ret = ((table##_t *)instance)->attr;			\
> +		__ret = instance->attr;					\
>  	} else {							\
>  		__typeof__(((table##_32_t *)0)->attr) at;		\
>  		at = (((table##_32_t *)(unsigned long)instance)->attr);	\

Is there a reason we didn't remove this cast for native-mode earlier in
the series?

> @@ -242,19 +242,25 @@ static inline bool efi_is_native(void)
>  })
>  
>  #define efi_call_proto(protocol, f, instance, ...)			\
> -	__efi_early()->call((unsigned long)				\
> +	efi_is_native()							\
> +		? instance->f(instance, ##__VA_ARGS__)			\
> +		: efi64_thunk((unsigned long)				\
>  				efi_table_attr(protocol, f, instance),	\
> -		instance, ##__VA_ARGS__)
> +			instance, ##__VA_ARGS__)
>  
>  #define efi_call_early(f, ...)						\
> -	__efi_early()->call((unsigned long)				\
> +	efi_is_native()							\
> +		? __efi_early()->boot_services->f(__VA_ARGS__)		\
> +		: efi64_thunk((unsigned long)				\
>  				efi_table_attr(efi_boot_services, f,	\
> -		__efi_early()->boot_services), __VA_ARGS__)
> +			__efi_early()->boot_services), __VA_ARGS__)
>  
>  #define efi_call_runtime(f, ...)					\
> -	__efi_early()->call((unsigned long)				\
> +	efi_is_native()							\
> +		? __efi_early()->runtime_services->f(__VA_ARGS__)	\
> +		: efi64_thunk((unsigned long)				\
>  				efi_table_attr(efi_runtime_services, f,	\
> -		__efi_early()->runtime_services), __VA_ARGS__)
> +			__efi_early()->runtime_services), __VA_ARGS__)
>  
>  extern bool efi_reboot_required(void);
>  extern bool efi_is_table_address(unsigned long phys_addr);

For the efi_call macros, their definition should be enclosed in
parentheses now that it's a ternary operator.
