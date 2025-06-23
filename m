Return-Path: <linux-efi+bounces-3912-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A472AE40F6
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 14:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CE018819FE
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B3246BB6;
	Mon, 23 Jun 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="a8e0Nell"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BF246BAC
	for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682795; cv=none; b=JkxaXlz+TpoEpGEyw7fuSI+HXHDHUcLZd+eekVsON5XbFwGZI3Jkg/UHie5SFraWzUkSXaPF6c3gRF1YyFThmIEoJl53jqVnYXxCxLdmaYpE+Lsba/ZjqvZU8s+QE0ZyVgCPYEZzKenL4KMjqWAoVEs0ulo5FpEJZBIpfW+BQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682795; c=relaxed/simple;
	bh=b5NxmT0loxx/7WaQWkE56b7hNY1ccSAUc6z7ZnyY3aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ddz2H4qLF4J0zVP2qzEwpSY0qBEjw0+Ey/jurReenAq0siyIGgtTSoR5mbTBTnEiYE+mihYk5bE1ciWeRXD/Rsnh8K7EV9S5/+T9tcmhrLkaycQ4XEEGVJVCNcjjkqMyNoQswM2qI+cBP8+PsrRaV1CcQ1mLtGU+O69Xf4Rg8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=a8e0Nell; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453643020bdso24435645e9.1
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1750682792; x=1751287592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4H/tpHO92SRA2Ij69Ydb2QlnQAlIertbl5lzibiK4s=;
        b=a8e0Nellg3GHJSCG8c2C1+F0Jnb5n9w5dshExpoYx3+QF1EDUvWdxFlMTY0Taeo2Vb
         zQbEY7DGahvRLvwz5Ffalm9xOgFbD8nwpB2DzkEP7WUqPqsEdgqgwj3se0juzmX1W1W6
         rSbbSgyCZXraPv5MNrYiPBdmciO1kZ7nfqvOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750682792; x=1751287592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4H/tpHO92SRA2Ij69Ydb2QlnQAlIertbl5lzibiK4s=;
        b=lZLS04DWVToESn1eZtKHp6lRpDs9KVjg5vjA26g8GbG6dx/XUHzt7SsPkMA6lluTS8
         5C1L4NrXnl2rT8mBv/GoF8n9bTZx8E1aVKALeW5EUg+WrMQa1IzoD2D5yMrugwZ9wwFq
         wxOKxfoDMa0+76RKa2De0HoXty4GdXPWBGD7BHK1+Fj1RcHIbAJN3sLZsCAryb7t33TW
         FI6rP5Xn5+R+jEwLbbBGpDaZ9rdZgcPH7PJuCNNjvWSDywvpaYG36N2LA4KOrIbGEG/A
         8creU3O8P3Pzg+b221tepMSv3tEDA8xVuxGk+vsDOo59xG4IwRzMD1vWVEFSK+KDqKjZ
         zTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu4OM54gYaQARq8T7kYUC0QiYcGFcmm7900/6iKOYxYPDBCJyNvesFqWmVlDsd9vKOrHXx8Ol3u2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YynifBa//13ML9XmjP65SEqc1hdxdl8qXgofigoDH9UnGbt56Nq
	gN9x7mHQY/bM/yAXkBYFW+khp7Hh0jNZ9Cu5Ove1FztXcqCJ8shz/OZ7k/d8iyfqVwM=
X-Gm-Gg: ASbGnctnBZ0ypBtB1AT7JR53Bll3wYLWKj0oiHpiTAlBxAm78POm4TDsMGWrbdBE7yQ
	H/JrMciRpb7Y4SEokNg18IUSqMSRwPXjjktG3y47Umj0BKF08/iCwo8oxRSxrpXC7o8i+N/nSWt
	wbmX3VipwfAumHznvy5aF6wDlrPY86y5XzIwoLowxKD1/GFJ1eoqFF1UekHey7CX7so3mWawmLz
	/UKTyiEnh5+a9d7DnlxPnnVKER9nhRix4fSj996Z5rSYl7kQF8gKFTiQAKHwIFQlCxxXNRCYXds
	IrMwgFBzozTbHqB2YoumHwl1aq3azLlCc/azJ0Mc3B9Bb/p8hXQZ7EMUCLKcHQu8PF2/M5HEMjv
	qolf0wOuw9/FSwHfWbbD5FxklSOw=
X-Google-Smtp-Source: AGHT+IHq/gBXmdEX+L+ZpnkqzGMkvMtpLiNZHIPajaL6JynGzeHbVmwebJgCbvRP8bhGCgdTOLCykg==
X-Received: by 2002:a05:6000:65a:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3a6d1304011mr10012046f8f.23.1750682791723;
        Mon, 23 Jun 2025 05:46:31 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97ac4asm142289045e9.3.2025.06.23.05.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 05:46:31 -0700 (PDT)
Message-ID: <c290a3cb-1cec-4aa3-969c-8fba504eb3d1@citrix.com>
Date: Mon, 23 Jun 2025 13:46:20 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
 alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
 bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
 christophe.leroy@csgroup.eu, corbet@lwn.net, daniel.sneddon@linux.intel.com,
 dave.hansen@linux.intel.com, ebiggers@google.com, geert+renesas@glider.be,
 houtao1@huawei.com, hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com,
 jpoimboe@kernel.org, kai.huang@intel.com, kees@kernel.org,
 leitao@debian.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@rasmusvillemoes.dk,
 luto@kernel.org, mcgrof@kernel.org, mhiramat@kernel.org,
 michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com,
 namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
 sandipan.das@amd.com, shijie@os.amperecomputing.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com,
 vegard.nossum@oracle.com, x86@kernel.org, xin3.li@intel.com,
 xiongwei.song@windriver.com, ytcoode@gmail.com
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
 <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/06/2025 1:41 pm, Kirill A. Shutemov wrote:
> On Fri, Jun 20, 2025 at 04:21:38PM -0700, Dave Hansen wrote:
>> On 6/20/25 16:08, Andrew Cooper wrote:
>>>> But, the resulting code is wonky. It needs to do something more like this:
>>>>
>>>> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>>>> 		return false;
>>>>
>>>> 	if (error_code & X86_PF_INSTR))
>>>> 		return __emulate_vsyscall(regs, address);
>>> To do this, LASS needs a proper interlink against NX || SMEP.
>>>
>>> If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR,
>>> meaning that fetches are reported as plain reads.
>> Interesting point.
>>
>> I think the easiest way to do this is just make a cpuid_deps[] entry for
>> LASS and NX. If there's a CPU where LASS is available but where NX isn't
>> available, we have much bigger problems on our hands.
> I am not sure what I suppose to do here.
>
> Sohil pointed out that with LASS we get #GP on vsyscall, not #PF and PFEC
> is not relevant for LASS.

Correct.  That was my mistake originally.

>
> So, IIUC, that's dependency of vsyscall PF on NX. Do we want to disable
> vsyscall on boot if NX is not available?
>
> BTW, why do we even support !NX on X86_64? Is there such HW?

Yes.  Early P4 steppings had no NX at all.

~Andrew

