Return-Path: <linux-efi+bounces-6169-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOJvA1BelGnODAIAu9opvQ
	(envelope-from <linux-efi+bounces-6169-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 13:25:52 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69914BE96
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 13:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70702301D974
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1F2DB79B;
	Tue, 17 Feb 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+0lz/df";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1AqWm3Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4033984B
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331148; cv=none; b=Vju3aikxQHjEEDexNvpz2k9PDUNuOZsnQTehJ3xDWMrg29qNNFWhDyNF6OqveQSfCmv9aWqCeEhDdD708bJhGaYzmoaJAL2weFl+qrZoZeYIkGY2wOyJbVFp1g4N+oCBRrKMkjbyDWyvM+Z+SbmNuW93nOSpenrkrTmtjDmuR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331148; c=relaxed/simple;
	bh=zlG9r37NLTwZYql3LHVYwpMDYon+b9HfdG6ekrexrVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8S1W86WmH4Eq7CaG5yHPicSSSitUCdwkwONpfjS1mi/0Bik8+cm5EOeWLAvbVYbS3YyV7bp/Rk5wZmMWsXBnBhrC1+67bd+CDwNMYHTOwl0CNGLN4SPZCdUmvgGu9yVrF6pLs/dNB8RnFbOymjmz11KLSUKN4m5PWNSSmLyB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+0lz/df; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j1AqWm3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8Sx55297054
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 12:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ne+Xdf/klpNlR1z4hftn1Ok1OX4m0aO3qAGj4Do7clQ=; b=k+0lz/dfjjsnmxNR
	aBDAvatxGHy7hAkDALDL3Ze4mJVJRNLq7ORjuf98K8+FsUOfD+00XEZ1iUh6Fl0A
	6VZRDEPrloUufWBkezXWbrEr4AkFjh9IzTVPaVmZt/ANTzI2ua2FpM5+LrWOA8eC
	w0U2CK9wkss0yayqga8jjAZTt9IJ9kbkVI3uAoYPrNv1dYdM2wsxHx9rJXU3gRic
	PsmJgU26+RnQvSSpevsVO/An2XBuAxw+Uy1U6T0u8ysz+mDMPWF3HZtqzAnlQ+Z8
	ulYXSpcAN6t3DNtXbJjEneJdbyZ4LlKm1OQKWIg5tD/bsZQroTToIT6xwXg/craP
	up/3lQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9tar5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 12:25:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso7646385a.3
        for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 04:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331145; x=1771935945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ne+Xdf/klpNlR1z4hftn1Ok1OX4m0aO3qAGj4Do7clQ=;
        b=j1AqWm3Y/Iz8yAa13H64S5R5gBg4/Gx2qMeIgw0g7bbzDp9j/uAfTASed9gh8hNYgr
         vrxd/Hmy/8J4gTPvFOEA2fvWQ1joIOlUYySHJJ91BTxURsfFoZXOmvBeHQAte9ezN/Nh
         5EelRbUDj47ITaF9NvFtSuGXLlnoKbied3LW6bGK0ZvrCQk2xosVWLi1aVF85IpV4EJF
         i7VSO5whzY7vnbX/H9Jm4gLRLMaZrMazl2roc1va+OS12Mb6HRiBO2WbeWo3lYJ9OVP2
         13/+6ECevNwi67zp0MXEJzk55ol4Tk/0jQsQJvUgbxvC+T9mzy/YcIHy38t+ClSlgdho
         GqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331145; x=1771935945;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ne+Xdf/klpNlR1z4hftn1Ok1OX4m0aO3qAGj4Do7clQ=;
        b=DVuGtLiVrusfu6IrBGoldT8eXQxv9UHxVOIbjgcbUqS3QPZ9dztDb51luHplkhJFpk
         zcWlXE+kwAkGRK5oLl71uygWNf9Xo2yVpu35CYGzlxRXJT27wf7h/m/h9O3yNkc8CnG4
         /NKpouchzHPGK1n+FDhcYfqoB91gr7j2rYHQJBYZ2YTneZ5qsrIaifemhNEPdsjVz6mE
         n7wPFMKkOkeK6P1jTIUxblbpVNXOYCDJDVNaaV1uzT/aE8y57dkOPAIHJJsveQ5tGDuE
         BWBh3Y3CbqHYSjgDux/7qsiEFUBlC+itPZ9PuNPcJoDkodJ6Dl5SCxSV3deNH1KxHXko
         /P4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRNJQGAUGqTleKCEQv1iBYf68EEQhI5tQgoCNkhIHMsqtsfsdESuYSgN1Lws5bG6nvvhwW3m9YDYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7VippnN58yFVF1f5pKz0Tz5ktm6PzsQvT9btVPS3mic9aZOG
	qGHMLix7dvG0QsWBg6AWoss4BhQ0K5DBgwjDv3o1LtbCqRiS+r8LvqA6s5LA78qP1rpLm9lsFV2
	no5zCIJlxXfMvrUv4Vf8Am1qm5o3APkNYPJclvX4ZzP4zbr5aciconUG3XdbQ4tU=
X-Gm-Gg: AZuq6aJgsEJi89/gIch1XdFBSF5s6PCPNzmNmXEknijjhPwy6/BofDYmF6TB+xxZx71
	SjyMBixk10OFXRgnydTQeuY3YRM0/JeNVCdVO6/tp1Db+pjUh7m0ym6WGHVXGzRnHScorCjifCz
	YQkwJgP7za0dhsu38XV555FuDoMpBpyAuCE1s8V/CHtZjznUHFqHUSnwLcwWk+xT5TuVJ7wRuiX
	36fnVRixTYgHxupzlVt+jQ4+b2Fv7Ig0n0PmERLHPiBzXePt4FI3GqQinNEmgx8GFcYeR3TlCrp
	C1rIt7yKIkqP+NaiPsSiATzRtWaiSx+E68dYF76kezBi3sOmysMogvnAqji/al6JFa6p58nCD+/
	8JFLPcIcnLh9PER5/0odtqYyo9sCQKKrJ+nON+602z/xwU56aOg==
X-Received: by 2002:a05:620a:4709:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-8cb42262ee3mr1602128585a.8.1771331145174;
        Tue, 17 Feb 2026 04:25:45 -0800 (PST)
X-Received: by 2002:a05:620a:4709:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-8cb42262ee3mr1602125485a.8.1771331144703;
        Tue, 17 Feb 2026 04:25:44 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm36628978f8f.27.2026.02.17.04.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:25:44 -0800 (PST)
Message-ID: <3ae05b60-0428-40ec-a6a8-e60395a8dccd@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:25:42 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
To: Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com>
 <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
 <CAC_iWjKXcp8mmUaFphHRjJc+n3RNasVi91+_eP-mm3a9pnmYSg@mail.gmail.com>
 <5823f778-d422-4190-99bf-d66ffa437f6c@oss.qualcomm.com>
 <93de9e85-faf1-4394-a374-f9207bd823c7@app.fastmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <93de9e85-faf1-4394-a374-f9207bd823c7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMiBTYWx0ZWRfX0Om6mAq14L5L
 ZZ5/e3oFyfr/LOwffSUmWi/zP+SLS0DAnrPHhPfx0IMswsqAyL2u+5pO7bUEGN3YU8N/aCdu6DZ
 gGEhryXuObDx4p3E5s1kMn63iF9qggY8usjyMz5JytbnE3eH2o0/fPf3RiW2MJW+8fFHVVtDA58
 77gtua/Z1m6H3oZcN1JK/YEQqnxbAK/136VcoEickjMFtAeD5gIqNIVmr20cljCF1Ja+3PoCCwZ
 fGfNRqv1PaBv1xz2853pSvCYMLAWWoGo8ADhvO6Yun9Oj39+7wsGEQ9xVMVsyH2zSnDfoIgc1qj
 NAcqeGrIiMwYu0jQocaUJPace0rAsk59Aizr4kYWXqMrotHTM2NM+eMcSIohWg/OwZLA05XTq7L
 G8YryVBt0LK945yzz3tWzgvwDb15gB8YWaDUSX3QLIOSvtsGBOihTNYSZIsGSEThetCcNNi8Adg
 nB+tz5TD5ZeT4oEbOyw==
X-Proofpoint-GUID: 0n7S2qAdU4uYf82DdPX1SODiWuFgy22O
X-Proofpoint-ORIG-GUID: 0n7S2qAdU4uYf82DdPX1SODiWuFgy22O
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=69945e49 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=_Y02hFW8pdDoch4LnTMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170102
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-6169-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D69914BE96
X-Rspamd-Action: no action

On 17/02/2026 12:30, Ard Biesheuvel wrote:
> 
> 
> On Mon, 16 Feb 2026, at 12:07, Krzysztof Kozlowski wrote:
>> On 16/02/2026 11:43, Ilias Apalodimas wrote:
>>> On Mon, 16 Feb 2026 at 12:33, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>>
>>>> On 16/02/2026 10:49, Ilias Apalodimas wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> The 'struct efivar_operations' is not modified by the driver after
>>>>>> initialization, so it should follow typical practice of being static
>>>>>> const for increased code safety and readability.
>>>>>
>>>>> get_maintainers doesn't include me in the cc list?
>>>>
>>>> I use only get_maintainers and as you can see no. You might want to add
>>>> yourself as maintainer of this driver if that's your part. Or have
>>>> korgalore/lei filters.
>>>
>>> Hrrm, that's weird. Running it locally returns a more extended list
>>> which includes me and Sumit Garg.
>>
>> You might be using git fallback, but this is not a maintainer. It shows
>> random people either involved or not involved (like cc-ing me on half of
>> kernel drivers), thus it is not recommended for daily use and all tools
>> (e.g b4 or personal scripts) do not use fallbacks.
>>
> 
> The code you are touching came in via a different tree in the current merge window, and so this patch doesn't even apply to the EFI tree. Those 'random 

It can wait till the merge window finishes and then it should apply
cleanly to your rc1 rebased tree, no?

> people' are the ones you should have sent this to, if you had taken the time to look at the history of the code you are modifying. So please don't lecture other people on how to use the tools.

We are all using the tools. If Ilias is/wants to be the maintainer
(which I support), please add to the MAINTAINERS file, so the tools will
get it right, instead of relying on manual process of finding who
touched something. Contributors should not figure out how the code ended
up in the kernel because it does not really matter. What matters is who
should take it, who is the maintainer.

This is not a fix, so original author won't be pointed out by
get_maintainer poking at Fixes tag.

> 
> I've queued this up now - I'll send it to Linus by the end of the week. Thanks.
> 
> 
> 


Best regards,
Krzysztof

