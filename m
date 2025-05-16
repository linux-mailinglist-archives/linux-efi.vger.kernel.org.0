Return-Path: <linux-efi+bounces-3750-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A084ABA2C3
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026113BBD74
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B761278768;
	Fri, 16 May 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GCnfT63U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28152701A7;
	Fri, 16 May 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420145; cv=none; b=E8uQlPYviDlq6L5TRUyyXNKaiOie37a2nJ0pOj7T+DLPZNCAtk0iqIBIUp2cSYF/dHBlzcEzwEs8gkRQKLf/E4uPrmWQyA2t6EV6xesGaSe7XGh39dzgwSIXgEoS/HNkhqNEav5iL1+nJtHupEo9iBJPYuKeXsZpG44ndLMvMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420145; c=relaxed/simple;
	bh=1fx++dC2G7xSlPOJeN/lnsabkaaWW/8faZQ+ylHw9QY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m+2/cO7NyR4ewDsZZsEUkbTXpWOkiduoO9TgJdzN8gwxLrbpib7NBmJYTESCnMzh7XY/oxiAffstPCByJ4JYTOkH4gPUHcq3RWpfNkyeS1DFsLvItAnSpApCmXZ6xNTj4l/BA2e2ZDU1GNNtZ8J8KzyrDLXMqUlok3tnuHsRi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GCnfT63U; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54GISMke189240
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 May 2025 11:28:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54GISMke189240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747420104;
	bh=3kdcS+HU5yAUDKLqMb85cLKeCxs+E5AFWAZY7/43xqA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GCnfT63UVHPPWk3YILYl72t8nFDrdhAUhsSKpxTGreTT2ddjyna85jiy6hjBNoU+H
	 zO0Amspxwwj3SrM0jc56ax9egcxoqYJ0Mtq2SZJYd4neyBWLdaIJY4ZKeLWT5063eG
	 GPKZ8dzj0/p5DYkqI2VD1Y24LSyVzviNL2aaV5LWGeTsVbr3rTqY4jOc1mjP6inPtv
	 RQVuKLUT27Sxx7NTlIMfs8SzYGZF1GEc7dzddouFfGdMSkTcHAYM/IC8oclN28dELh
	 rx0KqNw70zDrEFNuq7sZbnxlNMP+YfNXvQUThV8kiFSVLTFtl/CEhlQU9m/8QVROkV
	 7d7Ljwnra47+A==
Date: Fri, 16 May 2025 11:28:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Sandipan Das <sandipan.das@amd.com>, Juergen Gross <jgross@suse.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv3_2/4=5D_x86/64/mm=3A_Make_SP?=
 =?US-ASCII?Q?ARSEMEM=5FVMEMMAP_the_only_memory_model?=
User-Agent: K-9 Mail for Android
In-Reply-To: <6c33159d-8e4f-474b-a60a-bfa95eca6042@intel.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com> <20250516123306.3812286-3-kirill.shutemov@linux.intel.com> <30570ca0-8da4-4ebc-84d6-0a4badfb7154@intel.com> <rqkfqkkli57fbd5zkj3bwko44kmqqwnfdm766snm26y2so52ss@6it24qxv356q> <aCdGzpXSVx15gz90@gmail.com> <a0ca765c-a506-4c1f-a38c-24a8074988df@intel.com> <aCdbOeK3EkVUTGD2@gmail.com> <6c33159d-8e4f-474b-a60a-bfa95eca6042@intel.com>
Message-ID: <304EB2DB-3EB9-4D2E-8807-E170B9061A63@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 16, 2025 8:46:07 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wro=
te:
>On 5/16/25 08:35, Ingo Molnar wrote:
>>   =2Econfig=2Eopensuse=2Edefault:    CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3D=
y
>>   =2Econfig=2Eubuntu=2Elocalinstall: CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3D=
y
>>   =2Econfig=2Efedora=2Egeneric:      CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3D=
y
>>   =2Econfig=2Erhel=2Egeneric:        CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3D=
y
>
>That reminds me=2E=2E=2E
>
>Does everybody keep their own local copies of these configs in their
>environment? I do, and I refresh them periodically from the distros=2E I
>assume everybody else is doing something similar=2E
>
>Is there a better way?

What I do is keep a set of minimal configs which are the deltas from the d=
efault=2E=20

