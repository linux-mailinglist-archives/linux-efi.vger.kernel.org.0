Return-Path: <linux-efi+bounces-3794-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF44AC533F
	for <lists+linux-efi@lfdr.de>; Tue, 27 May 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8CF1BA36D4
	for <lists+linux-efi@lfdr.de>; Tue, 27 May 2025 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27727FB0C;
	Tue, 27 May 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNkLricT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4727F737
	for <linux-efi@vger.kernel.org>; Tue, 27 May 2025 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364295; cv=none; b=R+L1Ozb3l2P5BRUqyl9qVTo5ICPgapA/NY/Zw4AcPk1KeOT1A1hxkXFLt0Xkq/3kkRunt0IhF8gTWLIqTl4QlOgxqO3CbdEbP+v0dFRLGtsqurOL/4fDdjCizG+eXD+T2aUAoKZjpMjI5Sp2aNIvTZEqaBWxMXzYE2zSSGCxctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364295; c=relaxed/simple;
	bh=YQJ5Y/glLmAKoQr5dvAuvWJqArl6gIzSqIc37GUdMUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pac6Clcr77kri/bVzBApNhIK7Qxa+du4uG+QDT7c7srElEVv9mZeDkfw4xl1l5FiqgBFB7lgLgHCy+NU7n1ImHycM+nblkZMtdc6zA8sbzHEG692u5//2cpdWQXKq2bzoKuLVNp68YDOaarY0e02o/vhlq2MDd9TnnKxTT+a87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNkLricT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55320ddb9edso2596854e87.1
        for <linux-efi@vger.kernel.org>; Tue, 27 May 2025 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748364292; x=1748969092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5A4z8idvhrlOUm9it3KkLJXHuCr29pgoYIORSBD9TU=;
        b=iNkLricTcmkQ32pNTImHeOIQfSWJHuSFcDAMoB2DZqmn2qEsRKp2MQYRByPZ4h94cC
         XdreZsnhcvZ/UQ5HC9Oty/UFf7Ywg0bGIlIZUfEMjl3KuUxz+xtqeF3uB/78g8RbmfBh
         VO13Tgs2Zl/1vmit6lLQ9sZSlGlNDGu7p7UXPtVpTbT1F7dKlLO4JyBBK1JM44cuQ0DX
         12He8xWAH0AOLIOfbymi+K6djY/S/4/Z+H2goWqgue+7ceMoY5EDcs1E9Tdtb2Ji7n8D
         PHqJag984rxMY1OOTNnFnI0xIMYICsrr+14l1P22XOLrnXblbmh0TcNJSWq4HELDgpl2
         ojkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748364292; x=1748969092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5A4z8idvhrlOUm9it3KkLJXHuCr29pgoYIORSBD9TU=;
        b=B5/DbHaZclEyNnMij6ymnV13ptCBxWWGob2k05G5rsUSck1KVsucZaP9hQ1YW4DkD+
         5IOD7rjx4TLfX1S7KjBsxINZTy7ecvXopQe9+a9WXCK93ZdDnN5AX56dq4G0GOATY7Wy
         975rHqsFLMqPGTRWKJYNGhXCFHIyCY3fJI5fxWh3WjyyRCkPwERnDqdNx79XkKTD6oE+
         3/4spncjXYnm3Dsz0bmuVIguVs6DUknmA4H0mOQ1r58aW+vHX6meUe9a+3xFcWtp9y2h
         Y5F8vDDn71iqG6mQE8FXnB51atbETUchEzPTf4g9UxOjhtQFsiPeOEiDZ2Y9tnqVVfmL
         xUeA==
X-Forwarded-Encrypted: i=1; AJvYcCVo5ch7Oz5ZrpbbMSh2QIotsXJg1mo+Ku4GM6E63tY3aV6Zvh3AvPrS+JaX3kgWw6S6w4JU+tDnaVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5NKUffMExYENDHAiULaTgEbGTqhtwBBnzTZKVu7N29AUHhu5
	7YTxEPzyCxBkjtLvTQ9gwKrWXTFbVatRshKsQIr7GiJ2R6SCw2GxuuTsd8AQxixyiFVR3SEc/2w
	GKeQKLvfFqNXxIVC10XDsgB+CxjFnrzPVk17f/ggC
X-Gm-Gg: ASbGncvNLE0lEO9sX2VTMN4BzOEvKJB+WFgZVcbN1lEXq66j/B3/j7OnP35ikSIzJN+
	QUJbvwY+blI4tcuI8wO2JzNMy9BO8D92/bGK+J5Zqv1+JU1KKRLh7xI34naqJgm56qAeSi1GilD
	3A1LzRTBPidXJ0rJQ55sZRQ3CN9wZV5FFPO9iOcRGEXCt6
X-Google-Smtp-Source: AGHT+IG/h8v06G9ALBq3kMuLuMnCc0pX6R8Hsw0GvHZOftlFSEKI/3wDPROoYBwYqNq8NJ4g87AN4IhUq9rx89c3iII=
X-Received: by 2002:a05:6512:3b84:b0:54e:752a:ae5f with SMTP id
 2adb3069b0e04-5521c7a99e5mr4056444e87.8.1748364291421; Tue, 27 May 2025
 09:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527144546.42981-1-kraxel@redhat.com> <20250527144546.42981-2-kraxel@redhat.com>
In-Reply-To: <20250527144546.42981-2-kraxel@redhat.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 27 May 2025 09:44:34 -0700
X-Gm-Features: AX0GCFsUUiLqSU3MxdqUqyI_mJiFndCPXUTUWQVzFQES0xVHvwC1G3rVIaB4HrM
Message-ID: <CAAH4kHYMyJ0Td47KShOJGntRPs6RLcJ97oajA7z9VPdUbjT+WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa pages too
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> index a4b4ebd41b8f..1136c576831f 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -215,7 +215,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
>          * When SEV-ES is active, the GHCB as set by the kernel will be used
>          * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
>          */
> -       if (sev_es_efi_map_ghcbs(pgd)) {
> +       if (sev_es_efi_map_ghcbs_caas(pgd)) {
>                 pr_err("Failed to create 1:1 mapping for the GHCBs!\n");

nit: update error to reflect the expanded scope?

>                 return 1;
>         }
> --
> 2.49.0
>
>


-- 
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

