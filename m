Return-Path: <linux-efi+bounces-5687-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515EC87DE1
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 03:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C19A0354A97
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFA23ABBD;
	Wed, 26 Nov 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IyF3IUnx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432C800;
	Wed, 26 Nov 2025 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125491; cv=none; b=J2za55+hKlJJSFSIuTUDDBuRlc4QhMxJs3x2rkaaLzMhtGqRfTD5gXPnAmZK2GwwD8o3JHT+wM1ivUV48J/3UN9RrPvh5srOGsIkZpDqpHdB8ya24pvbWaL91dxilaEONBYeugIGFMPl1mTrsg1AO72qqxrHn/Ty/CJBdPFFGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125491; c=relaxed/simple;
	bh=S7TYziOQ+/njeiekbnqgHtfwz06DQfTi/2sQQEUPSdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICcBwvXOdoqjC4Mkhg9vy/OXqJhj3C8TRDkMbk+5BF1seQsuKNqqQv3e7Gnrhw5ykxIiaffwb3rwY4rsdrmDr0Fs2mlKG/woyI81/20dbghsUI32T4UfUmPux10+oHJDHrn/oXN2pWm8kKCGkAwO/MlAO/0WNXhDluffmFer6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IyF3IUnx; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764125408;
	bh=XJOpPYZjaJRWccjVxi9dhHN3qiSJeRfkHuTBVyFKxLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IyF3IUnxjqBYQSjsmSqCji7RsbXvVERpjlJLpVdCCjQAIfI6H4qJrtbBQZG2eqWrR
	 +AhDrzovp9RpKmkS+CvLNCMmUKeHoNQ7RZbt8iQNjoD33crKaoPWWCuyf+eEDelm1g
	 FDQteRryWRV6wlrR/9TDGW51jOJoaoQXh8uiK6ZU=
X-QQ-mid: esmtpsz18t1764125397tac080787
X-QQ-Originating-IP: UEl+Av4ckTsfsHc37ZGqCRNl+H3K7DoOfDcFYABRAW4=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:49:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7550926216381406590
Message-ID: <EDFB880EFCC6C35F+1cf65f69-6feb-4c59-8c6f-aa22c0b95ecf@uniontech.com>
Date: Wed, 26 Nov 2025 10:49:54 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message
 print
To: ardb@kerne.org, Paul Walmsley <pjw@kernel.org>
Cc: ardb@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251031024328.735161-1-maqianga@uniontech.com>
 <f9d632d5-22dc-8b14-8a70-37737a78f206@kernel.org>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <f9d632d5-22dc-8b14-8a70-37737a78f206@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MKbpLBOB35np1S6I4VJSlLS9XZiaEL1bpIEl65371hcPX3/16D54OuLq
	5jyNwngaaC7MOUTXm9XId/3lVzmDI9gGn5MU16nJZLMi2J7U4tpHPy1wS2qD9QIMV01PjuD
	2vpNeP+/OhslDt1A0+t9rUyA0iU8HL3AbnrLW+A1W88DlnTUeVqL652aAQSd7hkL2P0N5r4
	GSMPqU6eXv4rczcZadDqEvdZ28AJZHDP696y1cz8+Ro9QwRB5rc4pNQQ1H0d2qhwVZkvT4C
	3YDKaTZnNUK9YqbTvW6w/S67QvbqihpBX+MFe2ORAu/lNu4f0fUqN+Iw9VDfUwGFzIm6BgH
	Mli3a+J2JZR1z923XGaP9zeNIV6/F4nj3ZWzqLE4xm4pnLzU6THnqarX/wUBcPQ+Y9ZqW8B
	ye+UMTDybV5MVtcnn8wPF4rEgKWz3NxR7vGEJw5YlRztvqGRXzDYvqcwToVY0I1dqHuSV56
	gLghiJG/jk2YOV+yV5FuWQuecOAdcggFqUyKjdms0nm0V+6kv/6tkrIXX6DI5TXidCV0Ysh
	PLM6fcUlBhdD8y9QrDJ/KbZFvMIY+ogWHTcPZT4SUJV25cPOBozeEakModDNz4STylwiNpn
	+p/UAc3x4qnWYS3QXpjj96hz1/qF7L6OfrNLAo1jNxJWOfWee4Mj9puJ19QSoWPvhEQfdiW
	JnQ8f9dXk9xXesRtB46mo5+x4dfFfJfdqkdUUB6BtM6YtFgdRuKlIRFeBw4dUXmRdDIiGSn
	X0I0OdF1mo6qb0Xjoz4G6GPnpCbyS0zmzNGFa8cX1q8VeQrlYol4jQDDR6fXpCQ5HXPlJrW
	auc27a7YDzIg9I8HkW9tNKKpw/mjdXdLJ/nHsx4jUzQ1SyNaypwQsHy2QleHAEIjda5uzxg
	DJQN7z4ypdKEddbuChOpJFFS6TIw/FKy4Hdldl4B2IKr4ZG7TA3hRPFrXvrZaJmXcItU5A+
	dyFOVNDuZ08ue25DFg21IOxXfbfCDRmQEpWuCZRwcxrEH7QJlz9dUpyz3iUlNvU1bSaGqwl
	6Cdtd20w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0


在 2025/11/26 08:27, Paul Walmsley 写道:
> On Fri, 31 Oct 2025, Qiang Ma wrote:
>
>> In the efi_create_mapping() in arch/riscv/kernel/efi.c,
>> the return value is always 0, and this debug message
>> is unnecessary. So, remove it.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> Considering that Ard doesn't think efi_create_mapping() should be changed
> to remove the return value, and that the ARM version of this code retains
> the debug message, we should probably keep things the way they are.  But
> if you can get a Reviewed-by: or an Acked-by: from Ard, I'd take it.

Hi, Ard, what are your suggestions for this patch?

Could you add a Reviewed-by: or an Acked-by: to this patch?

>
>
> Thanks for your patch,
>
> - Paul
>
>


