Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285BD1F8438
	for <lists+linux-efi@lfdr.de>; Sat, 13 Jun 2020 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFMQIE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Jun 2020 12:08:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFMQIE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Jun 2020 12:08:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05DG6SXC053556;
        Sat, 13 Jun 2020 16:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=30/oPhpA1qAThmKQL1/3XVNjqzsa6gOj7TyT+DemyYo=;
 b=fKsoXxNIJIi92dhn4hIn+J/Emcw7d6wRPkZSTEngZYdTsVjG3LaDsKmqaPPicQUCUKRp
 Q3UC+JmBnHZKTkvwstEMglXWaneGcozSb0NmbIMZrYWvZKoM+2wEi+nzPpC8IBzooyyc
 vIdEoxpPAJRCyJbChxxbtHYluftZedQkA+OylZDxH2QUSy+VawSGzI3jHhj1ATyBcVlT
 qIK6AzJ5exqc8Nwr9Z2RJ1/nObxeQ1f5A0Gecm744crOnj/aOIDKXBDUVv9lUMVAYp/d
 kGVcHi6g1DpzEQ0FQQOFXZcaHqIuR6vO1iNOGVTb5qSVfGrwhRwn7Evcc1GDFgptkgpM iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31mp7r1hty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Jun 2020 16:08:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05DG3FXT078425;
        Sat, 13 Jun 2020 16:08:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31mkwqtdq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jun 2020 16:08:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05DG80OS014603;
        Sat, 13 Jun 2020 16:08:00 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Jun 2020 16:08:00 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: v5.8 EFI firmware driver does not compile on EL7.8-based systems
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAMj1kXHhnaGCQhu7+ct3dKWvht+O0gi2Ksn+FUZdNzc=vcfc6g@mail.gmail.com>
Date:   Sat, 13 Jun 2020 12:07:59 -0400
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <373354B8-5182-41E5-982A-C6F0C698E55A@oracle.com>
References: <D81D56F9-9451-4048-8484-1BEBAA07099A@oracle.com>
 <CAMj1kXHhnaGCQhu7+ct3dKWvht+O0gi2Ksn+FUZdNzc=vcfc6g@mail.gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9651 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006130144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9651 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 clxscore=1011
 cotscore=-2147483648 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006130145
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Jun 13, 2020, at 12:06 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Sat, 13 Jun 2020 at 18:04, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>> Hi-
>>=20
>> I pulled the top of Linus's repo this morning. Reporting this in case
>> you are not already aware, and to ask: Is there a new minimum gcc
>> version requirement for building the v5.8 kernel? v5.7 builds fine.
>> If you need me to, I can bisect.
>>=20
>> [cel@manet linux]$ rebuild
>> Building with 13 threads
>> In file included from =
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:1=
9:0:
>> =
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c: =
In function =E2=80=98efi_char16_puts=E2=80=99:
>> =
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efistub.h:52:51: =
sorry, unimplemented: ms_abi attribute requires =
-maccumulate-outgoing-args or subtarget optimization implying it
>> #define efi_call_proto(inst, func, ...) inst->func(inst, =
##__VA_ARGS__)
>>                                                   ^
>> =
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:3=
7:2: note: in expansion of macro =E2=80=98efi_call_proto=E2=80=99
>>  efi_call_proto(efi_table_attr(efi_system_table, con_out),
>>  ^
>> =
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:3=
7: confused by earlier errors, bailing out
>> Preprocessed source stored into /tmp/ccWY8q9X.out file, please attach =
this to your bugreport.
>> make[5]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 1
>> make[4]: *** [drivers/firmware/efi/libstub] Error 2
>> make[3]: *** [drivers/firmware/efi] Error 2
>> make[2]: *** [drivers/firmware] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [drivers] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [__sub-make] Error 2
>> 3132.08user 498.43system 5:08.21elapsed 1177%CPU (0avgtext+0avgdata =
451516maxresident)k
>> 3488inputs+6959272outputs (7major+90023497minor)pagefaults 0swaps
>> [cel@manet linux]$ cat /etc/redhat-release
>> Red Hat Enterprise Linux Server release 7.8 (Maipo)
>> [cel@manet linux]$  gcc --version
>> gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
>> Copyright (C) 2015 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There =
is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE.
>> [cel@manet ~]$
>>=20
>=20
> Hey Chuck,
>=20
> A fix for this issue has been sent to the list already. It should be
> going into mainline somewhere during the week.
>=20
> =
https://lore.kernel.org/bpf/20200605150638.1011637-1-nivedita@alum.mit.edu=
/

Thanks, and sorry for the noise!


--
Chuck Lever



