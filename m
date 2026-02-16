Return-Path: <linux-efi+bounces-6149-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIPVK4f6kmlx0gEAu9opvQ
	(envelope-from <linux-efi+bounces-6149-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 12:07:51 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D6142AC2
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92C93009B39
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7DD26FD93;
	Mon, 16 Feb 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vfc7ZzBN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGzDk26C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BE22B5AD
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240068; cv=none; b=DuDT5hg3LhA7WN4n4lMtt7eKnSxAX8c+mvSYcklBgoNAIwiqXP8Oog7LKKOm69QvEdC5y8NFbYlD+G9/kxhoUyGV1POQ9r33D3EqPVbkGk5yw5bIGN4sFcKqRqyrdecVxGohafvTBoDGpl69kaafdER+M88QNiO90xEg/xnRVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240068; c=relaxed/simple;
	bh=BGWMtl0BJ4xY8y3jZpHxeiyFpi2oRDkH39KUjh/AAkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxLpfjFIi6CInTz5FaGWIh0uqjR5oyChFE4k/YDz65Ft3m2VwbCGDeOv6+1TkzCK2CfyITOLO2x6jitEqEDr9/bEN797QHO/OZ+FO9oHKuz7lbRMyMaxXQ8ljZRW30FqjYWbyybQD0gemwQEP71uiPpBuK6zapueLDRA7eA0HPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vfc7ZzBN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aGzDk26C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNcCbx3685271
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 11:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/meIujfQJ3G4YCym/onp23xGAtccwS/AmTaTduP0MU=; b=Vfc7ZzBNLVRCgkcW
	nRVFDaeXCjRdSBSVu9jn4ZGR4po3g2Vq6aF3aoSCFXHI9wTspANQH8u+w1kN9xGW
	fMgfd0aOEW/Q5Qel6qxsDkn/e7Xm7lrUiz8/9yV3dSKZKoSyylXPzCDYYlrnezhR
	P4d+bINGrot1QRtbGK6MjSAoeT/9/vUK+dShdLnhfI4krqn5lRUAbA0qY26G+265
	NpghSbqgPzZ6q0HzavBlj+n+GNCQvLigvQVRIdOhjnsx9SNyCnTU6kKTODv+Mdac
	d0/JzaibLPmaqhg+BPa0eLyBY8RtIk0Buv9bRQDqbSVwp5Lord7DYQlQoEx7lPmR
	XQOsLQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cag24ccgp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 11:07:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71156fe09so1659925885a.0
        for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 03:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771240066; x=1771844866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q/meIujfQJ3G4YCym/onp23xGAtccwS/AmTaTduP0MU=;
        b=aGzDk26CmfzPVQiUD778sO7nHPVnTdEdlaIX2wNPrB8Wo628p7lddeHVDCrKZop9Xu
         WrXVHm0xjVmQUo8uJfhRc90iLqNBYb+tdQLcAmAwboTfloMqFNJ2joMHXojGBfTU43T0
         fSp22Efq2Rg87NulJ6MVCG00ca1WKFvtJe/IGaE2r+7TlY+6/Xy3mtRjUDFSEZby0HE4
         J8DaxuWhPApzcEjy3TXjFqE6ZUEw4i7+NJ4VGk68KbAxySIF4iJBDONXuS2NL3g8X4Et
         alEmhzgNYODzIjM2UQHPzat8pfzNHpdTTKnSOOA3eNZYrfvyDt3QNNsY3NN20vNJX1x1
         sQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771240066; x=1771844866;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/meIujfQJ3G4YCym/onp23xGAtccwS/AmTaTduP0MU=;
        b=gl5ef+qbFOtH5zK9DH7zUb3SgoLyB9NA38qD5nJU8na98vbKqaq8ZGWG16GA2Z65Rf
         W/Ekk4+/uRoVNowLmgOzkqYhElZr+1Ms5RJMM3WIMn8j/Lh9pURdxdy9lzuGwohoTfsK
         bg6VEkeLUp+0z2lnJ9SuxPjP6gIPUVTTdjAIaawcwG3eALFvlY3D/RnsYOlsLKwh83P/
         SqoGuuIm1Yf2df2dd/9mJ5VqI0ITzJsj8w3gq6MlDODlZgWItmVlENBbKu5GtoAMK8dF
         CblDLqVM6EhTxz02U9/MaY/m8XRWi2K3cAuDDNM6KbwLWUw318FefqLx95LxDs1tgWC6
         47Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUVJemM55pBjuWbsSk1frTje6L2tRxwQwCssZcd5270zbERfbID2Zq4tdnHXOuOUcNpLXB1EG2t4Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0BE055AcktdquXyjm6tTASszAGlvykGGHjkvqYqHq2HNC2VX
	5rzGJFxT+3+qzt751l1rk9uQIpj5n162HANYe0z2wQWCXOJfdQIN71g6Kj+J7Q91XpvjJlXBTJE
	ocMTgnN2i9yaDEgRrNA5kiZYxRac3cjRY3BzWgRkr2ixDudKDxx57cGhZpFSO09A=
X-Gm-Gg: AZuq6aIxNE/1e/y4K6XBvkvXxIYQtmrnrpQRADtLa9VvTPC27LVpKQJwZUPSUvRrVv1
	Qw8AHPGI2e6+utMpPZLhI2xsY7aPu0zeuS6uAXv/OJz4YQyJfpcsvqkcGWBwAq+8Q3HaipV7VYy
	76BdI5oHHMNf4tqSAltKqDgDYm/P0c/4D0nnAeZmoz+QP5x2qoDjBamOqVzdQeyQTcCXTuHJMHx
	UrZGRkZb3CMN9s/wyeAYywvWvBIm391tWqIUl3qINqvNNh4oxl/nSwetrTSbStdAwuZiukOCZOb
	+XjWPB7qFznh1MbkiXUwuXXoBV4JFFnjvpqekYPq6ryUHX4P4afBYIfNssiTo2MYYLX9DaEGm5f
	Tt5Bse4oPosRX0rcWJKRFwuwQPbGkmMKzBrjrETrpDGX8dWEXtw==
X-Received: by 2002:a05:620a:1910:b0:8ca:3d7c:e767 with SMTP id af79cd13be357-8cb4c00d093mr1016118685a.52.1771240065452;
        Mon, 16 Feb 2026 03:07:45 -0800 (PST)
X-Received: by 2002:a05:620a:1910:b0:8ca:3d7c:e767 with SMTP id af79cd13be357-8cb4c00d093mr1016115785a.52.1771240065020;
        Mon, 16 Feb 2026 03:07:45 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371998777sm294071675e9.1.2026.02.16.03.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 03:07:44 -0800 (PST)
Message-ID: <5823f778-d422-4190-99bf-d66ffa437f6c@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 12:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
 <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
 <CAC_iWjKXcp8mmUaFphHRjJc+n3RNasVi91+_eP-mm3a9pnmYSg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAC_iWjKXcp8mmUaFphHRjJc+n3RNasVi91+_eP-mm3a9pnmYSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LTsm8EnltJNYvEzJ62GRRcczHd_VOw5W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5NCBTYWx0ZWRfX4tzc/1hypX5b
 zEHNEmcyEeGTcEqRXLiUNVD2Qm2XFS+Df6P1fYAfmOWObnp8DgUNUzhL1BzJsoG9Mc57cfLpaL3
 zIAWtvjFmCjecxp1VeXJijeTLF48qe1DgIwA3OnPWrm0x8TB4K2bJkF+tiOIQGSpxcmlgiA75Kq
 tdPmQB4fHTJmSuHFfbdic0FrwBdCc6u0/G/GCG5YrYl0tmRohwUNhuyeyREZ6TkbWb9SPbjGTTQ
 5bfQbA8aqXZrnM3YwoS04B7r7Cz34qMGdGnM+apnFMpUbVC2gJrrhYPDrb1Vc2K8h1NtsjjQqR2
 HErDs3QBBQ4IsbTvyz/Tmqpv1vLCw7+7hPpJO+YWGQvpN98WNvS3Z9TRzY5ok5ACbrzcjtBXB7U
 38EwtjTHy3qElCjs0ER541Id9fqgOsSvZboz9I/NE0cvkyk8FUkuP5mp+2wYZHTvHrzkONq6hGM
 MoUC/QjBKvhytjde3FQ==
X-Proofpoint-ORIG-GUID: LTsm8EnltJNYvEzJ62GRRcczHd_VOw5W
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=6992fa82 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=057-S8aYvNixUhiuP08A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-6149-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 159D6142AC2
X-Rspamd-Action: no action

On 16/02/2026 11:43, Ilias Apalodimas wrote:
> On Mon, 16 Feb 2026 at 12:33, Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>
>> On 16/02/2026 10:49, Ilias Apalodimas wrote:
>>> Hi Krzysztof,
>>>
>>> On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>>
>>>> The 'struct efivar_operations' is not modified by the driver after
>>>> initialization, so it should follow typical practice of being static
>>>> const for increased code safety and readability.
>>>
>>> get_maintainers doesn't include me in the cc list?
>>
>> I use only get_maintainers and as you can see no. You might want to add
>> yourself as maintainer of this driver if that's your part. Or have
>> korgalore/lei filters.
> 
> Hrrm, that's weird. Running it locally returns a more extended list
> which includes me and Sumit Garg.

You might be using git fallback, but this is not a maintainer. It shows
random people either involved or not involved (like cc-ing me on half of
kernel drivers), thus it is not recommended for daily use and all tools
(e.g b4 or personal scripts) do not use fallbacks.

> I'll have a look on what's going on.


Best regards,
Krzysztof

