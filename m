Return-Path: <linux-efi+bounces-6069-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKzZHqIYfmmMVgIAu9opvQ
	(envelope-from <linux-efi+bounces-6069-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 15:58:42 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF9C299B
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A88F3002D1E
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F266358D27;
	Sat, 31 Jan 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvHzB4qP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ik1dSwSL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C03587C6
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871510; cv=pass; b=jtaUUlE4ipMvd45MICBI3ugyq8KmnjNl0+PZwf6YDSUDmM4rg07kb+SrupKHNnumf4zH0iXraLG6S2DPTf6UcK14oRkGLeN8v8sRAZLxHvc9cicwq/nkukMCNDgsFvacjqSeFZYOiyyc7Ajc1CbVdAavqQ/lZwXexWUmLBxig5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871510; c=relaxed/simple;
	bh=XoPjc3FsSnhAH36Ksfm3BAJI9jxzPUWZyt5vdnTXd18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDEkN+2B6dzG9U3LMQL5eFqzgoaak6JMlG5SX4jzCMjX5AU6cYBY3vRW6+2btWeLQE9Zu7ypZKwBLn2s2qhz0JRH3sBlhyY4OLV8cSfDoE9R1G+cnpx8/XD1V897OhNPosM5S+l67IQBwH4lB+5vq4p4ZxGbnVnDloQSWRlqP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvHzB4qP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ik1dSwSL; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4eR1K393163
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=; b=OvHzB4qP/0jw0pjw
	qHWpKU9MTVgAy76IZFOwvomNtT5ojMnLFjv9vAMABxUYDDdhCdM/mdh/1U5ckbR1
	OHXys8Fv+a3PchmsefgHP4EyfqjCbDSoUrH0Z9vDG2TJsjY7dmvbMOIBYgB07cQC
	ID8YMzju3Vh/8MpgAyNwHRivnN+v5eYDr5CIhLCfTj2mGS4XRYyxzAUFh9cINBG3
	4lbqX8kwiPdpC2X1VC+X57Yc4hGnLxfwp4WoeziP1V7KW8OWpTYzBS2/84Kelkij
	c7Hl5zdRcBv8uYhTITx455LsNqpLBdwF+tnJlsXg2fGzqhfqDBQ8OAyarNxVhK3m
	+a43bA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awnrx4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-794784532a0so49472907b3.0
        for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 06:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769871507; cv=none;
        d=google.com; s=arc-20240605;
        b=IM4nV4wXOS2iuaXRZQvtDrn7f+XqhiYgeyDXHkqm2T1Dv7HVScDWAE7Xx2Eb1u+z/j
         kfGMjR4BQNZFcN4zwd08Peyxdb3v4BYJwhA6gUENfT9CmmOheADYIt1Mp+8Ac5j85fWT
         0TKAohiaMc9/XW2bbdOyrwSLkYl4lRc6LbwfGt5uZnycaCkPLeGpiNsOxZtD/0Os9mha
         s7P5gKWMniEGyBZY3FB6PlYx9SNoDtTOu2SoXXoOWlpDKSqAK4dGLSIO0NU9z7+wLHl+
         MFO7rifc2++eJ2RJ/SUoxdXMWHUHecNM5AOZZTvG5lF60aSpNnNRFnrMISQm6lpJLklx
         78eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        fh=OMoGfKTOf4d58ItU+gbAyQnL8UQmub3IhxWL9Z7wGxk=;
        b=gLYPHxz7+/IMeeIMlGactJ4+ysADZCI4zY5HVWu+2zqpZJlWPd+1RM8yITktKp8h1j
         HH4YOYSTCL29hxLH02bqA1YtJ41FY4GTRaL+pR4ppu+i7Hr7YkYnz8l5kweonEWKC0vt
         F8aVOyedYJehX80QxabrM9TCdjxGoVEwuMkL5YykKMZr8sW4585QIuUe15ph9GrPfpuM
         QrASf+CxecwyF6k/rfs4drDERM+yl8Sgr+10WphMSdWIb//BR9xKT6ZW4ztVjqHfVHRQ
         w5qmMPQUUYLj4VPKC2v+wspxkAfj2DCdTY6S9yQXohfTJWp09JN1yKcoUJXkRrPR/33c
         7o7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769871507; x=1770476307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=ik1dSwSLQ5gKPr8itJihjb1p2ii6Z3jsGGCTSkLMElBTfrxMKk2BzSGAZs6Y3u/2Rm
         5Jc6JSviSstpkzoM62LilXKmZWvAB9DOuIyh5Gb+T0bn5eaFS/fm+ubSY0bwOoKcsOy0
         uUtdXIcMt8Yss89aVvVX6L4TWX7ziVDAwkZMGPY0zF71BzqoENGzauAVtQ4TysgmoZlo
         JTHS3Hq7Z/oREAC5DERRmVVlk1h39H69Q2dO8oZHQipUVCajubHib4a4IvOOCF6qUMnD
         V0QpB+SrFFffsYYxdEviApG9Tsmxy5nAA4c6446S0S+5+7eyl2juS3VlFK3vrM2U/7eF
         ejDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769871507; x=1770476307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=Deu5oucPsSnLdohPtrLbRnkqrPjxcsmyI7eyNt+nhBk2AMp+i1mOoEJzpEKeAV/x8h
         Dv50CX5s2WViPBZ9kCvrEuHxfgWpmAGHC4z2yErC+LTThS+QvhQd5kntj0/4Qz1diOIT
         MhTgolZrnA/iOx6b8vqxUn1aHHGu+MBhHXzZ6wRvOK4xAmtVPWqc1DeqZ6znH5028C4y
         3lYVQ0dwexN8hX+XTcGzu+SXbplsVbVXcBxVEAKpJxJSyS/UCWFS+JVN6HrzkaQJtebt
         O8aoNAybB+I2lF4PRS4YwBOSwbxEFFWCTFpwb7i4KGCKiEUSjYrBXQKsWDETlgpePFp5
         P5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWD5atozZ5zFarW38s3j2DQ+hh0D9mOihRuAo0gLz5Q2gbxwFdZZd5FPk/U08ygXAkWM0cuxNu7WjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6GJm1irdkVAFcRNtHbVDJ15gmKSMNbz1Jak47ZUxitt5nAbd
	Z9OBgGG4miJNL33WQReTn2F91D5PuBZYuEbasklzuGpc4n2jwVPvJqBC4QU5C4TUguw/l6epne1
	nVZ5HRGplA2lyG0Ca0PUExaI4RQERp3mDSqAbFwrrnGeIUvp8ynRgp4IXM0V8QeNfRMeuwxhNBb
	Cz+XkcjBmOn+OaGg2/CEAExm7jFU2wRcw0EtlyMQ==
X-Gm-Gg: AZuq6aJ4/8FIdF5Dcuz2G46r1l80sT4ax8jV64GKPHHYrxZ+AjCBuhzgrIxf05dlUOB
	oBNL0Ez8TGm1uuRllvv/YPIrHgZgOgcO2d+2adveo4wUCbtw3VO4nWyJ232srBhfEIxqSSByZcw
	ZI1j8PuOZ5NHh2DVtsrxoxg31FXtNmYsnk5NO7jOLoPho6sIk+tmjb8GvQHXWLoyGxfmw=
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id 956f58d0204a3-649a8547db8mr4403450d50.95.1769871506924;
        Sat, 31 Jan 2026 06:58:26 -0800 (PST)
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id
 956f58d0204a3-649a8547db8mr4403441d50.95.1769871506570; Sat, 31 Jan 2026
 06:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV> <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
In-Reply-To: <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 20:28:15 +0530
X-Gm-Features: AZwV_Qjt6-X-XbfNyo2_bleHjewtRG1qoA5gEXW9Hu9LjqRyKmxz-97xcVzcIio
Message-ID: <CAEiyvppoiL2EiSmVvNV3DEkr7wwyC1Fbwhm14h7Rfus4Z8uP7g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Samuel Wu <wusamuel@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
        neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, clm@meta.com,
        android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=697e1893 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=drOt6m5kAAAA:8 a=wEBb_YokH4NsbSDSc3AA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: Q9QecDYAvXx0mxwbk1U2UE4mb6MTHVkz
X-Proofpoint-ORIG-GUID: Q9QecDYAvXx0mxwbk1U2UE4mb6MTHVkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDEyNSBTYWx0ZWRfX136mPMX6ta7V
 Z1BqRltrGFjtg4QhwbAG17rRO48fWBoyKhdVYwC+9zxsJsULtjlWm0aH5BCbmHnESzyDPEUSVWZ
 P12OZ5OSmSYYqOtIzLzqCLA5iQFgh3zK8Y6FByE9X7V/x0PZwRPWr10CJS93fD1nxHSOYl2BpN6
 vJfTqN26TKHtL4iCr5vYEQKM/KtDNB3nWHUxWxvAGy819iR55xxyFek59SxuHwmaLaiZWdum3ON
 8eQR4Hr6fioDxlXKFRQ+b5guy3RWv4FAlJAMe9xT+aB+2SUDPjp7trrhbNa/GvICBMH6UFLM4eU
 LkH0CNrPTZ+LIzNFUxUA5hD5Jmrm+mGEbqK7EFIl6cg+ev35oBlm3VA2DkmsLrFKrVpt8AyBJs1
 y8TwINvkh6a6bGHMyaxqOG2zVlcL7PHHHvlXE+OQ3yExPIoMl5s8BCnvyCsfgwa2a5sJv1RPRRo
 JA2wwkSRoucaG/35Vyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6069-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.kurapati@oss.qualcomm.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: 99AF9C299B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 6:46=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Thu, Jan 29, 2026 at 2:52=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
>

[...]

> I'm exploring a few other paths, but not having USB access makes
> traditional tools a bit difficult. One thing I'm rechecking and is
> worth mentioning is the lockdep below: it's been present for quite
> some time now, but I'm not sure if it would have some undesired
> interaction with your patch.
>
> [ BUG: Invalid wait context ]
> 6.18.0-rc5-mainline-maybe-dirty-4k
> -----------------------------
> irq/360-dwc3/352 is trying to lock:
> ffffff800792deb8 (&psy->extensions_sem){.+.+}-{3:3}, at:
> __power_supply_set_property+0x40/0x180
> other info that might help us debug this:
> context-{4:4}
> 1 lock held by irq/360-dwc3/352:
>  #0: ffffff8017bb98f0 (&gi->spinlock){....}-{2:2}, at:
> configfs_composite_suspend+0x28/0x68
> Call trace:
>  show_stack+0x18/0x28 (C)
>  __dump_stack+0x28/0x3c
>  dump_stack_lvl+0xac/0xf0
>  dump_stack+0x18/0x3c
>  __lock_acquire+0x794/0x2bec
>  lock_acquire+0x148/0x2cc
>  down_read+0x3c/0x194
>  __power_supply_set_property+0x40/0x180
>  power_supply_set_property+0x14/0x20
>  dwc3_gadget_vbus_draw+0x8c/0xcc
>  usb_gadget_vbus_draw+0x48/0x130
>  composite_suspend+0xcc/0xe4
>  configfs_composite_suspend+0x44/0x68
>  dwc3_thread_interrupt+0x8f8/0xc88
>  irq_thread_fn+0x48/0xa8
>  irq_thread+0x150/0x31c
>  kthread+0x150/0x280
>  ret_from_fork+0x10/0x20
>

Hi Samuel,

 Not sure if it helps, but Prashanth recently pushed a patch to
address this vbus_draw kernel panic:
 https://lore.kernel.org/all/20260129111403.3081730-1-prashanth.k@oss.qualc=
omm.com/

 Can you check if it fixes the above crash in vbus_draw.

Regards,
Krishna,

