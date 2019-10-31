Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42311EB142
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfJaNdE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 09:33:04 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:4302 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbfJaNdE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 09:33:04 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VDU4H9027501
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 09:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JUux8PuEc0Ibhk5I/PrrkpeZtKmIHqwRDBeoNUw567s=;
 b=FBG4ti/Vqs4hLRCMqWw5h+4xTARkMeBDEIAxtasjLdvk0vJnowNcUAIyzKWcsU3OX4iV
 AC1PoQNUG+ip1dJYbbhqSUEj7CmSZ3vvXefu3JqVof1aM69n42BEEmOduiErNouqfoNL
 hdnvRgMKQSb4anWctWcaNLd70W7QbaWDl7kj+fnMEATaFR7GQO5wr3hnewfmibENAmfT
 dtzAUZ7C5hP0AB2ZLm6GyAWAI/rdJ2e7lhmtmVQR4HVBj1xZq8EMG5UAKlDxc5NBQbAX
 pr5zhnXNfqU3OfizDO7u1zEl6ExwGnwXQWPU39qW+2n+YZ+haovGborhj2xcYzfRu42s sg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2vxwp0rn7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 09:33:03 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VDSRt2171391
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 09:33:02 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 2vxwmvrg7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2019 09:33:02 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="417519408"
From:   <Mario.Limonciello@dell.com>
To:     <linux@dominikbrodowski.net>, <ard.biesheuvel@linaro.org>
CC:     <linux-efi@vger.kernel.org>
Subject: RE: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
Thread-Topic: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
Thread-Index: AQHVjWGTpr9I+X/6bEKG+5hDBd8Fjqd0wyCQ
Date:   Thu, 31 Oct 2019 13:33:00 +0000
Message-ID: <c4d91a7b7345471aa1e2543149aa571d@AUSX13MPC105.AMER.DELL.COM>
References: <20191005113753.GA77634@light.dominikbrodowski.net>
 <20191028072036.GA113601@owl.dominikbrodowski.net>
In-Reply-To: <20191028072036.GA113601@owl.dominikbrodowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_05:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910310140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310140
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dominik,

> -----Original Message-----
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Sent: Monday, October 28, 2019 2:21 AM
> To: Ard Biesheuvel; Limonciello, Mario
> Cc: linux-efi@vger.kernel.org
> Subject: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Ard, Mario,

I had some discussion to one of our BIOS guys and wanted to point a few thi=
ngs out.

>=20
> in theory, invoking EFI_RNG_PROTOCOL on a Dell Inc. Latitude 7390/09386V,
> BIOS 1.9.2 04/03/2019, should work fine as the system provides EFI v2.60.
> Using my patch from a few weeks ago[1], efi_random_get_seed() is called
> from arch/x86/boot/compressed/eboot.c::efi_main(). In
> efi_random_get_seed(), the calls to

Just providing UEFI 2.6 doesn't guarantee an implementation of particular p=
rotocols.
the protocols are still "optional" but the spec prescribes how they should =
behave if
implemented.
=20
>=20
> 	status =3D efi_call_early(locate_protocol, &rng_proto, NULL,
> 				(void **)&rng);
>=20
> and
>=20
> 	status =3D efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
> 				sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
> 				(void **)&seed);
>=20
> succeed. However,
>=20
> 	status =3D rng->get_rng(rng, &rng_algo_raw,
> EFI_RANDOM_SEED_SIZE,
> 			      seed->bits);
>=20
> returns EFI_INVALID_PARAMETER, though I can't see why one of these
> parameters is invalid. When trying to use the default rng algorithm (by
> modifying the test to "(status !=3D EFI_SUCCESS)"),
>=20
> 		status =3D rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
> 				      seed->bits);
>=20
> the call doesn't seem to return.
>=20
> Any ideas?

You should call RngGetInfo() to find the supported protocols instead of mak=
ing
assumptions on which algorithms are supported.

On the particular platform you mentioned above, these are the only two algo=
rithms
supported (which you of course also mentioned in a follow up).

o	  EFI_RNG_ALGORITHM_SP800_90_CTR_256_GUID
o	  EFI_RNG_ALGORITHM_RAW
>=20

> Not sure why the other one fails, though, but the fact that RAW and
> SP800-90-CTR-256 are the only supported algorithms suggests that your=20
> implementation is at least similar to the RDRAND based RngDxe=20
> implementation in EDK2.

I would agree it's unlikely to have changed in any significant way.
