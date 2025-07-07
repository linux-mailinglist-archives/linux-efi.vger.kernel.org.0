Return-Path: <linux-efi+bounces-4176-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A03AFBD97
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 23:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311803B3048
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D9287261;
	Mon,  7 Jul 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/jmxJYw"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A5202997
	for <linux-efi@vger.kernel.org>; Mon,  7 Jul 2025 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924216; cv=none; b=KmH1bL+cPq5amgHilhwxD8sQdCBq83XKejYLfdoEacpP9a5MOxhrI0ra35QaxrQ9b44E40mATG4XHfyDGM3cVCEVfohABrzAsX+N514N79BwAe9geaXKNqf7ZTWUH6Qb8RcIZ7LBj7dXWhUc2ZfaJJVs/SjtRhw+G1xbg5pk600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924216; c=relaxed/simple;
	bh=qraLfGOkWN7QLQxcHgl8x+wEAGndG0VVZVx2qnLdX1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=epNe/DyTb8jsQ2EQibQdUzFU6rr6j3YLHqIhgjR1WS6zFuDOtR17a12uPpwFqj/BPmxNh0En24ZTDH+tXOKetO9tDTbqwEmYXmOOUV/25rE9Y7LLRlycUfAM3qj+e5FH3C4npmTwx16aP1p5jVi5AnSWIbW1CyjuswjuhujSJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/jmxJYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751924212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFmfSbRPK9NnltZIO87T7HNPKAPVfH87hDFIBdCROR8=;
	b=X/jmxJYwTMtEFeSTJBskl6niY1KFSyuqPZD1yJbaiUnjeWc8jJGCpZn9QzCzWrJh1fP2gU
	TwS38a9SMKQon6HLx2fR58D8m5W1/Ck5tadNnFMLg2OKzJFqOv4I0mULIRrry5u/aUB5Ej
	7k5Z8DXDf68VL4Of+1sTMOgreetjTyE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-pETd-etbNQe1VkQ56qEN1A-1; Mon, 07 Jul 2025 17:36:51 -0400
X-MC-Unique: pETd-etbNQe1VkQ56qEN1A-1
X-Mimecast-MFC-AGG-ID: pETd-etbNQe1VkQ56qEN1A_1751924210
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d399070cecso622671885a.3
        for <linux-efi@vger.kernel.org>; Mon, 07 Jul 2025 14:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924210; x=1752529010;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFmfSbRPK9NnltZIO87T7HNPKAPVfH87hDFIBdCROR8=;
        b=YCq+t5PfGQ3741J25yv4krs1mthpiy1qe71eWdQCR2lmlfXi65/hcjbzgMFlHksEHz
         n0js3brXbxCzs6/hY5Ei8ducuJFkNLrihnCaoPN4Lu7kJhPfkUg90z5DMiyzYWeE9on0
         mP7Bo+iUBBwOxfh6RAqlCDJubyncCkEV9rNxmPjMrZ89xLFhs8osaKxGZWFpADhdwbVm
         AeQ407hEbpepcNXVO1NuBL0t9EJh8Hs1AOjIOWtKBRE9DS2u3ei/Ubhdx5bTfZw+53t3
         B+gtdGCgpYwrQr/Zj3S9WOlhHk5PX+X27ykVtBPCecJM5ii//YO2CqeO/AAhdQEzo8LQ
         69lA==
X-Gm-Message-State: AOJu0YwKR0HLna2d9t5kDGEuCmYz0oOiY5R6Kmnl68hV1M8m+/Mhre8j
	rTBIgjz0/i07XpotMe8Cu8GqaTs2TzRqorz0RpV7w/kyKUDcbMi1UNQLbwdNyTYUvpWLRrskuCF
	OYtXoRZGlGuDjOv06nSSUJoKbRihayOakM5+EUAVAOrCzbYlweikkwhUJ8XQpAw==
X-Gm-Gg: ASbGncv2EpmAmFXGd+h8IKVs5+2amepfIQElrKw9WusuWWI5a1cPFIzJHiVFuiYQ2nm
	AG3RIfhZntQMVNcChgmVJS/dlxcSp9fVX87jgx92Wu59njMV26Hn9gJcAWQqHkfpHa4Nh2YMEfZ
	Lh/U3oEQoVEgOAvLU0P7MM+5s0R5678KjXH5lUGLnEMftLyL4vzn2kZYWuI6S7jURvJeSkQHEr9
	UD1Y/Awko3XnEbHBX0oWG6R0kmIZcNDH0AjrKT3IC2mZ7ijWQczhEopmwnC9o/fbudlg+j4I+/8
	qGA4xwH4+/xHVoZpDxXvA7bM
X-Received: by 2002:a05:620a:24d0:b0:7d4:675d:1d52 with SMTP id af79cd13be357-7d5df0f54b8mr1834267185a.17.1751924209908;
        Mon, 07 Jul 2025 14:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxGgfuw0SDe0K+wEH9J/GTIAFerpN+WwGi4PpPRqIgfqPxFB63z3MUMBzdnj16vPyG0nPprw==
X-Received: by 2002:a05:620a:24d0:b0:7d4:675d:1d52 with SMTP id af79cd13be357-7d5df0f54b8mr1834264185a.17.1751924209444;
        Mon, 07 Jul 2025 14:36:49 -0700 (PDT)
Received: from [192.168.2.110] ([69.156.206.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f861sm672455785a.86.2025.07.07.14.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 14:36:49 -0700 (PDT)
Message-ID: <e1644469-77ca-4770-bc79-5243a46b8a9e@redhat.com>
Date: Mon, 7 Jul 2025 17:36:38 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Drop preprocessor directives from zboot.lds
From: Luiz Capitulino <luizcap@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250606154112.311565-1-vkuznets@redhat.com>
 <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
Content-Language: en-US, en-CA
In-Reply-To: <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-06-06 11:55, Luiz Capitulino wrote:
> On 2025-06-06 11:41, Vitaly Kuznetsov wrote:
>> Older versions of `ld` don't seem to support preprocessor directives in
>> linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:
>>
>>   ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
>>   ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error
>>
>> We don't seem to need these '#ifdef', no empty .sbat section is created
>> when CONFIG_EFI_SBAT_FILE="":
>>
>>   # objdump -h arch/arm64/boot/vmlinuz.efi
>>
>>   arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little
>>
>>   Sections:
>>   Idx Name          Size      VMA               LMA               File off  Algn
>>     0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
>>                     CONTENTS, ALLOC, LOAD, READONLY, CODE
>>     1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
>>                     CONTENTS, ALLOC, LOAD, DATA
>>
>> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Thanks for fixing Vitaly:
> 
> Tested-by: Luiz Capitulino <luizcap@redhat.com>
> 
> (this is for the build test, not SBAT testing).

Vitaly, Ard,

Are we planning to include this fix for 6.16? I'm afraid we'll introduce a
regression if we don't include it.

> 
>> ---
>> Note: not-yet-merged x86 version of 0f9a1739dd0e does not seem to be affected
>> as vmlinux.lds script is a pre-processed version of vmlinux.lds.S.
>> ---
>>   drivers/firmware/efi/libstub/zboot.lds | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
>> index c3a166675450..4b8d5cd3dfa2 100644
>> --- a/drivers/firmware/efi/libstub/zboot.lds
>> +++ b/drivers/firmware/efi/libstub/zboot.lds
>> @@ -29,14 +29,12 @@ SECTIONS
>>           . = _etext;
>>       }
>> -#ifdef CONFIG_EFI_SBAT
>>           .sbat : ALIGN(4096) {
>>           _sbat = .;
>>           *(.sbat)
>>           _esbat = ALIGN(4096);
>>           . = _esbat;
>>       }
>> -#endif
>>       .data : ALIGN(4096) {
>>           _data = .;
> 


