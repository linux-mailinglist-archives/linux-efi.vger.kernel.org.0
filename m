Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE054D57A6
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2019 21:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfJMTPP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Oct 2019 15:15:15 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:12290 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728982AbfJMTPP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Oct 2019 15:15:15 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9DJFD7s013056;
        Sun, 13 Oct 2019 15:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=qPa9PXwrLvpB9vuWUN4C7wI5T4XphZNhOp1JJHxxtU4=;
 b=GFda+POyFw2m9ez4D3xQB7mIqLwUsBbopQ+Tq1nu0BMSdD+lQX2WREj5VNHlMv+Etdl/
 cafG5iN9nb2MYOPwBxWvrEjqQucyzY12Hag0V0/kBkO4RsYvIBx7vAy/qz39By/U1fOf
 712V4yN+PBqVxixfNhHOtO1OmCSWfrlcitqDsuePeXZ9O9qFiXrAuNmJkrFvBMEOO64m
 tmFC9bG7g0OqwOrewCBs1iDm8zYvHomxMLMuVp3X+FXAi9SuRcIFiTlaXzL4jUugmfU7
 rC0A1nDjS96H7rTTZ3xaqAqnYjrcYiT5YRPKvRb1OGJiAOurb+XIED5fsBw7DdvlUZqC IQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2vka28cmh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 15:15:08 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9DJCp15093450;
        Sun, 13 Oct 2019 15:15:08 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2vm3hek34v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 15:15:08 -0400
X-LoopCount0: from 10.166.134.87
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="409573857"
From:   <Narendra.K@dell.com>
To:     <Narendra.K@dell.com>
CC:     <linux-efi@vger.kernel.org>, <ard.biesheuvel@linaro.org>,
        <Mario.Limonciello@dell.com>, <geert@linux-m68k.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Topic: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Index: AQHVgfgBvGXu4mhWM0KINjBW7iNITKdYlNQA
Date:   Sun, 13 Oct 2019 19:15:03 +0000
Message-ID: <20191013191450.GA2792@localhost.localdomain>
References: <20191013185643.GA2583@localhost.localdomain>
In-Reply-To: <20191013185643.GA2583@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C1695738C57CA4C95FC2D0A4BD65518@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-13_09:2019-10-10,2019-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910130192
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910130193
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Sun, Oct 13, 2019 at 06:57:05PM +0000, K, Narendra wrote:
> From: Narendra K <Narendra.K@dell.com>
>=20
> For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> for input on platforms where the option may not be applicable. This patch
> modifies the kconfig option to ask the user for input only when CONFIG_X8=
6
> or CONFIG_COMPILE_TEST is set to y.
>=20
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fix-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Narendra K <Narendra.K@dell.com>
> ---
I missed mentioning the following details -

This patch is created on kernel version 5.4-rc2

Changes in v1:
- dropped following changes
	'depends on EFI' as it is implied
	'default n' as 'n' is the default if not mentioned
	splitting 'bool' to 'bool + prompt'
- added dependency on X86 || COMPILE_TEST
- added the 'Reported-by:' and 'Fix-suggested-by:' to give credit to=20
Geert Uytterhoeven who reported the issue and suggested the fix=20


>  drivers/firmware/efi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 178ee8106828..b248870a9806 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -182,6 +182,7 @@ config RESET_ATTACK_MITIGATION
> =20
>  config EFI_RCI2_TABLE
>  	bool "EFI Runtime Configuration Interface Table Version 2 Support"
> +	depends on X86 || COMPILE_TEST
>  	help
>  	  Displays the content of the Runtime Configuration Interface
>  	  Table version 2 on Dell EMC PowerEdge systems as a binary
> --=20
> 2.18.1
>=20
> --=20
> With regards,
> Narendra K

--=20
With regards,
Narendra K=
