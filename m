Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB39A1F8433
	for <lists+linux-efi@lfdr.de>; Sat, 13 Jun 2020 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFMQED (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Jun 2020 12:04:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53680 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgFMQED (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Jun 2020 12:04:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05DG2iUU050963
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2020-01-29; bh=mMc4QYXC/zjRfKtr0TosxgHwWjXc3D2HtZ3AwfhZjR4=;
 b=XbRXDLkvPqScZDD0uV6xXpCYd8w+2bnBJ9uNUGBw06QqkmKNuCo7D4XNnafgG910CoC8
 vNfdmLqdOT3fXJOB2WlCl8UN3+AeZ4QOXvKDyiNjsPWsmKoaydaJXp73k3i21Ps/lAkX
 unxfeBYyBtG6q6ZKckQxTQtWNKRmlzm2HVKL1bCJuluGk6uqVm7iFK8luvLqlgYpE5lV
 e6ZktVJkJtOsGvEzwt1RGPvWEhfIdtbXTM933wC8l6kA4eJlsnCla2E6GxY94oeXpH9N
 BuAMliv00PpY2Bc342T9u7x2IrkQGTYMv7UDU0XfYEYgAg7/CZNb45aI/sVBVmOsKEuw kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31mqemsdp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 16:04:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05DG2Wi1023398
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 16:04:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 31mmu8xerq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 16:04:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05DG404n006284
        for <linux-efi@vger.kernel.org>; Sat, 13 Jun 2020 16:04:00 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Jun 2020 16:03:59 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: v5.8 EFI firmware driver does not compile on EL7.8-based systems
Message-Id: <D81D56F9-9451-4048-8484-1BEBAA07099A@oracle.com>
Date:   Sat, 13 Jun 2020 12:03:59 -0400
To:     linux-efi@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9651 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 bulkscore=0
 mlxlogscore=941 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006130144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9651 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=3
 priorityscore=1501 bulkscore=0 mlxlogscore=960 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 spamscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006130144
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi-

I pulled the top of Linus's repo this morning. Reporting this in case
you are not already aware, and to ask: Is there a new minimum gcc
version requirement for building the v5.8 kernel? v5.7 builds fine.
If you need me to, I can bisect.

[cel@manet linux]$ rebuild
Building with 13 threads
In file included from =
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:1=
9:0:
=
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c: =
In function =E2=80=98efi_char16_puts=E2=80=99:
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efistub.h:52:51: =
sorry, unimplemented: ms_abi attribute requires =
-maccumulate-outgoing-args or subtarget optimization implying it
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
                                                   ^
=
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:3=
7:2: note: in expansion of macro =E2=80=98efi_call_proto=E2=80=99
  efi_call_proto(efi_table_attr(efi_system_table, con_out),
  ^
=
/home/cel/src/linux/linux/drivers/firmware/efi/libstub/efi-stub-helper.c:3=
7: confused by earlier errors, bailing out
Preprocessed source stored into /tmp/ccWY8q9X.out file, please attach =
this to your bugreport.
make[5]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 1
make[4]: *** [drivers/firmware/efi/libstub] Error 2
make[3]: *** [drivers/firmware/efi] Error 2
make[2]: *** [drivers/firmware] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [__sub-make] Error 2
3132.08user 498.43system 5:08.21elapsed 1177%CPU (0avgtext+0avgdata =
451516maxresident)k
3488inputs+6959272outputs (7major+90023497minor)pagefaults 0swaps
[cel@manet linux]$ cat /etc/redhat-release
Red Hat Enterprise Linux Server release 7.8 (Maipo)
[cel@manet linux]$  gcc --version
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is =
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE.
[cel@manet ~]$

--
Chuck Lever



