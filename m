Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917D8C929E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfJBTtW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 15:49:22 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:22996 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbfJBTtW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 15:49:22 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92Jioxb015061;
        Wed, 2 Oct 2019 15:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=RmZ+BlTQEGuXdY8dqzyNWFsSYkMxU7IlisLgNQKAmUM=;
 b=KuxFZlO1bNTgP/5s1cUQwH2xpyURY1WtKssRmZBjDLxib7Q3wy/Bryk+z6KnjRVCtovL
 u0PDt6d4EA1Kz0SJnVOT9HIm5/AVmHS9cZDckkp4mMn7ilOMMJYvPjCvzP8q+jIV7/E0
 mATTeizKwIxAyTJIHuoHOYg5Clvrag0e6MROjn8d9FHxNBNY84N0ALq6L5gO5+YmtF8F
 l57/utifT+aruB0OBj2yH0t6ssVJ39lDKfNnZGOwirf0UDIHQSrkB9hHnFZp2YpwKiry
 lFcLEiCFdLkcJ0LzPYCnO7U1ZI63IWejYkfLpY09z1z8OYDOD47ytqRfFjuvsnsCYeeI 5Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2uk4pwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 15:49:21 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92JhBM6062520;
        Wed, 2 Oct 2019 15:49:21 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2vamkm10tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 15:49:21 -0400
X-LoopCount0: from 10.166.135.141
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="404328498"
From:   <Narendra.K@dell.com>
To:     <Narendra.K@dell.com>
CC:     <geert@linux-m68k.org>, <Mario.Limonciello@dell.com>,
        <ard.biesheuvel@linaro.org>, <linux-efi@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <tanxiaofei@huawei.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Topic: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVUR9fTJBv0Z/1EU2zTW0DTQ5+k6dFbG6AgAAA2ACAAAKAgIAACpuAgAA9PgCAAE5zgIAABjuAgAELs4CAAJ5ygA==
Date:   Wed, 2 Oct 2019 19:49:15 +0000
Message-ID: <20191002194905.GA3983@localhost.localdomain>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org>
 <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
 <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
 <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
 <8446d19dd197447a88eed580601f3c4c@AUSX13MPC105.AMER.DELL.COM>
 <20191001180133.GA2279@localhost.localdomain>
 <CAMuHMdUMh4mCczCOxFtLn3E0Wu84ixFBsFuXk0p9QVXtg4dmoQ@mail.gmail.com>
 <20191002102159.GA2109@localhost.localdomain>
In-Reply-To: <20191002102159.GA2109@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6126A2510C56E64E916382175ECCF4B9@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_08:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910020154
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020154
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 02, 2019 at 10:22:10AM +0000, K, Narendra wrote:
[...]
> > I hope I managed to convince you of the benefits.
>=20
> Thank you Geert. The description is helpful. I am working on it.=20
> As I understand, the issue is 'make oldconfig' provides a prompt to the u=
ser=20
> and user is expecting that a prompt is not needed as the option is not
> relevant.
>=20
> I cloned upstream kernel 5.3.2 as it does not have EFI_RCI2_TABLE option
> and generated a .config by calling 'make defconfig'. The .config has
> COMPILE_TEST set to n. I copied it to 5.4-rc1 and added 'depends on COMPI=
LE_TEST'=20
> to drivers/firmware/efi/Kconfig (did not add CONFIG_X86 because it is
> set to y by the defconfig from 5.3.2). 'make oldconfig' still provides a
> prompt for CONFIG_EFI_RCI2_TABLE.=20
>=20
> I removed 'depends on COMPILE_TEST' from Kconfig and modified it to
> include the below change -
>=20
>=20
> config EFI_RCI2_TABLE
> 	bool=20
> 	prompt "EFI Runtime Configuration Interface Table Version 2 Support" if =
COMPILE_TEST
> 	default n
> 	help
>=20
> Adding the condition to the 'prompt' section seems to have desired
> result. With this change, 'make oldconfig' did not provide a prompt.=20
>=20
> It seems like 'make oldconfig' will provide a prompt to the user if the
> CONFIG option is new and providing the prompt does not depend on the
> 'depends on' section. It seems to be dependent on the 'prompt' section.
>=20
> Any thoughts ? If the above understanding is correct, I will work to
> submit a patch with 'prompt' section modified to contain
>=20
> prompt "EFI Runtime Configuration Interface Table Version 2 Support" if X=
86 || COMPILE_TEST

Geert/Ard,

I submitted the patch with above approach.=20

--=20
With regards,
Narendra K=
