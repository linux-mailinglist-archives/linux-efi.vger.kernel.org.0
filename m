Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060A4E8888
	for <lists+linux-efi@lfdr.de>; Sun, 27 Mar 2022 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiC0P4b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Mar 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiC0P4b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Mar 2022 11:56:31 -0400
Received: from IND01-MA1-obe.outbound.protection.outlook.com (mail-ma1ind01olkn0182.outbound.protection.outlook.com [104.47.100.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE0120A9;
        Sun, 27 Mar 2022 08:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVmSPLlj4K8t8xGIofp2WNNzHU4TMaCGDumxmud8Bo077IFKb0fmgWUGyink+rMr1PE9fa5RaSdVyoEf+JPIoIw7zOgb1bf9t8jesox+yTa/6O+ZwrajiNHeLhdWN8i3qmNWQpGKeN83JM+vSPtUOiIitKHD9GVJJmJN5K77YuAi15JCX4ryHPGr0xVacoM3o8g1cruzpx8oxaNnRu3xompkFdAXMxtE5go+MsncuPbcGJC1gGBVsDRJwY95VHtsHnc10tzL+0IcUaUtMWyZagW7dHxbvbBq0IZJ+kznyvdBir34HA3XU/ZPrbSayNmY/08up5ZJUcCaa3cbu8T+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=332RzeANlZkgMlVT7KnX9t8T8LJu2FySmHdFdviKUw4=;
 b=nfJ5Vi2Kmkwcon44cmzmDrnGp6qLoG4phhM64iSIThTWCwmA2rXk5cDZAN4722sc4UEEZgbjDY8zDRxEEeuF84xY9cCcrjkGET3C77rx9ca9AwZvhzRv7vVRmgDU979iTGW2D/ugL29mX+oKNJk3FyV9l73aLH+lqObBVqiRsZq8DdkSY5Jmkg7MHApnpnQxXK0wXqnhnnB7bvweFoSmPERuAmOy/58E6MjswiV+8GEryhytO2sPeGYwfMneRvTA8GqG5TgIYcahPhgilUMdu/1FcL5/vbdowCsVEnba05V9Vr01ud8Kq4xEkkY1mrIiT1VfcFdGCnRCwboPrb8I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=332RzeANlZkgMlVT7KnX9t8T8LJu2FySmHdFdviKUw4=;
 b=qxVvlx3L0hnASB8oJ8ARUnQ/tAZ7jjtqQwhsH3H1TJNeY+U7Dab5T/R7EKB3W1HyVzTa2X6Fmgpvoq+g8I9lhvLEADxCaKD/tB0LeB0S2rDcLMxOS3W+y0Zf+kTnMvBC8/t8n3de55MiN+n0ERxsv6vXn5iylKQSQasny9Ljlu9a6EGkZyE117/Zu952PLXyD3FcvKdE7wSbzBLUXULCQEBjs/uoPRObQZeA3x1HWzcPm0e9Icz2jxUiy4iyIjznHOxzLWGTwZERTWXFGED+EkWFbwD6RXw4eD7PyJlpcqJKeXCtvTDhFkMutnLtWqyg9/MpwnUeA/wSyTvW3x5VlA==
Received: from MA0PR01MB7443.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5c::7)
 by MAXPR01MB4166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 15:54:48 +0000
Received: from MA0PR01MB7443.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1983:1d86:32f7:4c2]) by MA0PR01MB7443.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1983:1d86:32f7:4c2%7]) with mapi id 15.20.5102.019; Sun, 27 Mar 2022
 15:54:48 +0000
Message-ID: <MA0PR01MB7443B82F782378825531D702B41C9@MA0PR01MB7443.INDPRD01.PROD.OUTLOOK.COM>
Subject: [PATCH] Removing the unused TODO
From:   Dipankar Das <dipsonu10@hotmail.com>
To:     dave@stgolabs.net, axboe@kernel.dk
Cc:     linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dipsonu10@hotmail.com
Date:   Sun, 27 Mar 2022 21:24:40 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-TMN:  [DxIGcH3BlopwL89DYLTa5mnZNmdv/uCD]
X-ClientProxiedBy: BM1PR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::27) To MA0PR01MB7443.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:5c::7)
X-Microsoft-Original-Message-ID: <f585897e03b85d4ff13c96223893264c2a3de801.camel@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fba3e7b-da11-44b2-218d-08da100a1d5d
X-MS-Exchange-SLBlob-MailProps: 79Jo46q8hhAGd6HLJWKohVWz45gMXq9RzesEPAiP3hgmNAbZ46ZztfdXa2kOfTeCx2tsufgphnerouSYEmzCPVglKSvzFrZysjTYNwL1k/KUG/otKMm5DbDxpBZSffaJ8cyO6osh1cb3ww0rdY2ibzDoKElcbNpC8TQgb5RYlOcCRZJETH2cEIvVXrSE6Z17JEdSYlWYxp7jlRLA6X7cejFbFdGJkFoJNXB9smpxSIkyKDJ743U9yydPELdZCg4YKpXkd/Skb7imCkvA5yeyeMtjJvFcwqqy+PJS6a/x223N3ETLDEoWQKoU5vJjKu3GFfux/lRvtd+aYYxZpMZ5E+4/pSqchRWAlZoGx9FObn1CIs6j3I2Z5vmohqNJPLNkMVPyHnRcZqWeuDL2kXWyta6yHcSGrByPD7+i0Z9NhE/pGgOu1fmXi8TYh8Rjnl82wITwMh0Y50g2zVrC1MxdRULcN7PQmvvcKHwmW60dpqcHX5SGFt7x3cvWqrPntUZPrIWhKlXL1W4gPpIebDeVSOCmLIWTEYaLVwvOw931lL4TeYl1R/l+krYDaZQLywAlPD0Zu6edxqT4pyzS5BP8QtQYjhgsC/etfI/aLb8D6ygNjk6PrZdh8bbbF5bHhBBQJ79Y32FmuQuGdUjAu8lAzYSWJr1A0n+d2upqiP83vuw99hiwn+Zb6SiVu+PZ2COo
X-MS-TrafficTypeDiagnostic: MAXPR01MB4166:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQXVrXtcrs3TE5/Mj+H7p1SBpz/DEVQoFIUMTJ/yJC+eMLTdeVz+PiutERaLBKB0zejpAjTf3n0gJd9IcOr0bgcatUJycdudwbfKLjJ4Ebldjve3ULfb/Q+xSzwyk4w3CEsnNoXJouni2zDxOwu89JYek2WYxH//lBMUtAygS4AbdoBKKgLTiEA6gJRB8zkmARXfP06k/osyKdWG2jSV7hjnTn8r5RAV/dosl6BtC30hR9RaEkmUMsPL8ivpBUNNxOXpzIp++TUe3zg9yYcvAYHn0dI8e7NMbYh39o6SLFWqQYnSuavnIiCocYDLhjZYyOB78HRAYQT8/w6DPcWhVTpC6KCxx9rGhK+i5fraxNwX0mE4KR4yaZHr+7V7PncYB12gOBknFmB3BtTRxnzmja0zstkYRi+UygRr+PBJ8sfQJlLcXPsuGpcXM1x/On/DYR3jrBjRs8qkDjAh10u2tf8tx6HnJzdXtdGG+R85JpTeq2isJD22SQjkDRc0NDoeIaXPXlqHaHja2whN0mVfRf9IpM1nFd84nvTbgpwC7EeRKIzVT4jPBeW9jFekQ+l/HmuR+flmM+0H5cN8HGJGxg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NtSzVaWjV0azE1L3JUdXN5OFAvZCtTZG5pZFZrVkV3SjZEYWZkS3htV0pQ?=
 =?utf-8?B?aVl2TDNHVXRpUHdBeVBORVU1RG1ocys5dUp4V3NVV0lIZzRLSU15ZzU5SDN5?=
 =?utf-8?B?TlhtNys1bjN5K3pydXZyYVM0c0Rvd3pNTC9zMjJiWWNRZDFjbVFuNjA5ZHps?=
 =?utf-8?B?TjdKTzZuaU1pdjliV1NIa0VoWHBkQjVMcWh1WGY1R2VmaGtNdWlhVEMwL2Jp?=
 =?utf-8?B?WGF3elE1SjMvaXREYnE1UTlrY0lzdzFxT2lJaENHQ01EYzJiRS84b3VyTFIr?=
 =?utf-8?B?SjVteVFZYjRBNndETHJDb0pyUGxIRkU3MkNnejNZaW8wQWlZK2RobkpFYk1P?=
 =?utf-8?B?dU9aRG04eVQ4a3ZFNENtdEtwcmQwUlovNXpuYW5KYTNQTlB6SmluWDRJcVdX?=
 =?utf-8?B?bGFPeENUbDlWWk5zZlM1SWdzdmx0UTJubm43Q2FYQVArL1dPTTZmbTBrMnRJ?=
 =?utf-8?B?SjhDNUxTd2RtWVhGY0ZjZDFaL2tGNGVMMnR5allGR2JIclkwM1MyNGhkaHFW?=
 =?utf-8?B?WWJRV0J2cnpUZnd2ZEtCQVZFTTJpaEYvazhQQ09PNDFBK0RPUVdvbnAzT1Br?=
 =?utf-8?B?MG1qdTAzMDcremNENTR6RDZOU0VIbkdybERCZy9GanZhMlJXK0ZXZVNtSlpV?=
 =?utf-8?B?M3M4Y0hYaWd0blAvU1d5aEdIQzYzUzl5aXJ2TzBJOTkyNHZLc29odk4wblda?=
 =?utf-8?B?K0wydUEzNm01Q21QNmhkMFRTYWNZeVFFQk1OY2RocTJTSXJDVytnN0hXaEpu?=
 =?utf-8?B?eXZHWDhIYXpCSjlzSnIzMnV6TmZwWHh1aUprUmR0VDVmMUluSzJvNElFWFQw?=
 =?utf-8?B?NlZzUGdJT0hQeTNsSGk0T1ZIUkFtcmhibVh5SnlFQ0pGRFU4a1BHNXc0Y2U1?=
 =?utf-8?B?bzRWcHYzWU11NVZJK1lXQlRia3UyeW9KbEdLaEpCcGg3ejhGZytncy9RdGRo?=
 =?utf-8?B?SnF2ZVJyYk1jalVEYUEreExORHp5aElhMjJybE9iai8wOE8wWlhUeXZQblZR?=
 =?utf-8?B?NmxmTksyMVNmN2Vxb05pL3VyOHZWdG9WcHo0UkdwWjBOaHdLdjlIS3haTVlv?=
 =?utf-8?B?UVNTcUo3aHlmSHFjRVBuTlR3V0VJalQxR2hYZFRoMzFldW4yQkp4Q3pEWWJX?=
 =?utf-8?B?bVF4R2lWaTh2OENuUkdrbmF5MWIrV3E1ZVVSRjFpQ0VYODNsTktRVkl5dGlK?=
 =?utf-8?B?NUtmVDIzTkhGVzhWYTI3bld5SWxEcWp6OEVuUnhIRzZveFNvNXNLT0R0bXFU?=
 =?utf-8?B?TVZzOXRYSUx4WkVQK0VUS3BVQmRrZzdueFRlbnBTbVJ5RW1STE1NejJDdWpV?=
 =?utf-8?B?S1JhREQ4Ty9MdUdlU3RPU3Bhb3VLbXNJNkFVQzRkbHQxRGVXNjN6aG9ORmJG?=
 =?utf-8?B?UDIwTTF5M3dSMlc4a1V4eU1Hd1FsSDNVZzAzK21FNWtnZVNEV2hETEp3bjJE?=
 =?utf-8?B?WWg3VnVJOXJQeXpkaThoNDN1dzQ5dnhwUVdmSyt4YVlidjRQZmdWWVRRMkdj?=
 =?utf-8?B?Z2U2S2dzeU1VSzc5OVpaVGNXZjdOajJsamc3QjdqNTdTVHNaaXFRVVZTbkl1?=
 =?utf-8?B?VzVlRXpIdUdoYlp4T2tUNXdhSUkzMGh1RSszUFdJa2ZYY0p5SlZPdkFxM01Y?=
 =?utf-8?B?N3NDVUFSYjhuYjQrMTlTVkV3NHZCOEJ6V1dtOXNRdlV4MVoraEtRb3Z0czhQ?=
 =?utf-8?B?bUVNRFhGSjZxUkMzVHRvWnNUcXRhb3FWV0N2QXpXcUppSnVlOFJ0dVBxbUZC?=
 =?utf-8?B?NHlLbE9lZ2dVcXdENncvS0ZibTg3aUtMTFpOUDRGWXFtc3IvWGFycDZjaStt?=
 =?utf-8?B?bEI1bWJobmRVZ0o5Z0lOQ2p5OGZONk4vZFlsVnJuWkU2VWk0RkFSR2kzUDBK?=
 =?utf-8?B?OEpwaW1UODl1N25FK2R1dzVKb1UvSjhTWVY2bkV6SVcvcFI3ekxVTlQxQzdN?=
 =?utf-8?Q?og1usL92vbs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fba3e7b-da11-44b2-218d-08da100a1d5d
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB7443.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 15:54:48.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4166
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From 429f8f717c7a2b36ef75b7f747e05971c53ed932 Mon Sep 17 00:00:00 2001
From: Dipankar Das <dipsonu10@hotmail.com>
Date: Sun, 27 Mar 2022 20:06:40 +0530
Subject: [PATCH] Removing the unused TODO
As the TODO didn't had a message and nothing related to it

To: dave@stgolabs.net,
    axboe@kernel.dk
Cc: linux-efi@vger.kernel.org,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org

Signed-off-by: Dipankar Das <dipsonu10@hotmail.com>
---
 block/partitions/efi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..87d4788fe274 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -8,8 +8,6 @@
  * efi.[ch] by Matt Domsch <Matt_Domsch@dell.com>
  *   Copyright 2000,2001,2002,2004 Dell Inc.
  *
- * TODO:
- *
  * Changelog:
  * Mon August 5th, 2013 Davidlohr Bueso <davidlohr@hp.com>
  * - detect hybrid MBRs, tighter pMBR checking & cleanups.
-- 
2.25.1


