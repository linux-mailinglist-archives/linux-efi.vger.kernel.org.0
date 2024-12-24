Return-Path: <linux-efi+bounces-2457-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0A9FB822
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 02:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DBD16465B
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07348F66;
	Tue, 24 Dec 2024 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTvRZ8WV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBF372;
	Tue, 24 Dec 2024 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002781; cv=none; b=FZ48E3GMqaUPAwnSNC2svVvOhYwo1cPfInWJ9vWrcjcxroY2enTUW3U3Ss8zT05+HYUiTqKzvG3lWjGFGAUqdNmRSpHL3KGfUfR/l+zGRc3eOxm/MAmQvM39rIcYszxU/OitcWhenK0x3X3SvWBJ8zbcrwFE9Z261nubsIs+c3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002781; c=relaxed/simple;
	bh=gBzo0TsTHVq5EE7cP3zJjMmpv03XvuAwlF+cgKEGl4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXK/4F/8RrfWSQ3JBXwm0qapiWirpdE7e+SiirnGXQOqBqBV9xXh1x5fHju3PhKKuJ/EgV91aG3P33Ed9lFLEEIh4lngw3YdMKyzHF6YyVtMVAdA4efYXf0Y5whp0cJ+WQnOSKxBcw0qUFvgJo528Kq/ok/mcf5SbnFbIXsK9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTvRZ8WV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNEdUPK020183;
	Tue, 24 Dec 2024 01:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7LTy3+
	qcIMcjFutY9FBmUWQ9rexhOuVgFr1GEJJnLEI=; b=sTvRZ8WVh6k6YhRihVlIeF
	NdfcuScfbirQSCTU6YSL68AQ8cksJ7URyflvs8h2GUCXVbqA1N3Ws5da1xPchXlq
	ObatPmjOkCLsXNHpXFxYZvtSaDsSWWt+DEGWUGwPGF6zWD0y3buhJQOVCRs017qu
	rk/oBEqVo0IRcnGNh1C0yFBOOe+mILExvUCkapCy38lZc3G5iePdxGrrp81Emois
	uN8LkhOQ/Gwh3UFig5fU2BCYRK4PAKiMpQEXNKqCNazCjjvGs/iK1Wev/q1Wa3Po
	ZcNoWK7nXzn48fSrG0cOO0h7kIAJ5LpJFNe/GEmnjdIqKyuZhErjCh6bCzMvAo8Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q0bh4x77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 01:11:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BO1AuLp021037;
	Tue, 24 Dec 2024 01:11:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q0bh4x73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 01:11:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNNfTiX020197;
	Tue, 24 Dec 2024 01:11:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p8cy84nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 01:11:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BO1BaCR9765402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 01:11:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5DD158043;
	Tue, 24 Dec 2024 01:11:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75A4558059;
	Tue, 24 Dec 2024 01:11:34 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.60.117])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Dec 2024 01:11:34 +0000 (GMT)
Message-ID: <110996a70889fcd9f8452b7bb993732b716c919a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 13/13] clavis: Kunit support
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, mic@digikod.net,
        casey@schaufler-ca.com, stefanb@linux.ibm.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Mon, 23 Dec 2024 20:11:33 -0500
In-Reply-To: <20241017155516.2582369-14-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-14-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OUgtaAXRwi0YGR_kRmEbEBgacM-JjVxY
X-Proofpoint-GUID: PsIxg0Y5V-rtSmUTSczEGELShNeEb-vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412240005

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> +config SECURITY_CLAVIS_KUNIT_TEST
> +	bool "KUnit tests for Clavis" if !KUNIT_ALL_TESTS
> +	depends on SECURITY_CLAVIS && KUNIT

Change KUNIT -> KUNIT=3Dy

> +	default KUNIT_ALL_TESTS
> +	select SYSTEM_BLACKLIST_KEYRING
> +	select SYSTEM_REVOCATION_LIST
> +	help
> +	=C2=A0 Build KUnit tests for Clavis.
> +
> +	=C2=A0 See the KUnit documentation in Documentation/dev-tools/kunit
> +
> +	=C2=A0 Run all KUnit tests for Clavis with:
> +	=C2=A0 ./tools/testing/kunit/kunit.py run --kunitconfig security/clavis
> +
> +	=C2=A0 If you are unsure how to answer this question, answer N.

thanks,

Mimi


