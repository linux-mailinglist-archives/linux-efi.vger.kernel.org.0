Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CE485C7D
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiAEXvm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 18:51:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39982 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245569AbiAEXvF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 18:51:05 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N4rFv025697;
        Wed, 5 Jan 2022 23:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=moN0N9AohXo6kI25Abl/whL3aL6xWbMk0+iw4AQavBA=;
 b=cEuTjykI1umvhjReQrGFnJUfG4UPtWbarCrKBx7CZi5gG9B7ot1vmpX6Tc61DZdZt85e
 zDHsBmqegeUW3YL7MqzzHZd5hULPYGsSVBk9FZem9+Oc31sJY94ljaRoW3hpl1dgxlu4
 Eg1bPhbgcx3VbUCTRXrTuK1RzAhGVktdxpF14yYVGWod4MT7cbjFwahqRekvRoWQfmTg
 A6cdDBqHnLTG07P+nu+HQCR5majCyn6IwtmklPAMEaXz+sJk3VeLa0iQ35xGZazbYQwp
 atb1BlRDFsV/OeRtAuBeHrbCgwUkMul05Eew+6tLibz6XEpiWyzhuVqLHs/llvPIv4+E Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmg209-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205NjHlX177030;
        Wed, 5 Jan 2022 23:50:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3ddmq5shfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 23:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktsOn+QcRWJWxTfywr8YBNRiFDEJ17xmklwrXVJmfBxzurfRQdrbJntAbrjKg4rx8HyLQSNDHNH3H+4PefJQJYo0ECP6EnkV/xCbjn9w5VaGUnyDdB9zg1R2pXXiEn4Ng0K9x5Hdn0C4U306rEmmvn02W4RDgmpjwqGHDdRYNrndX+J3uZVsYvAH2QAiYg12Md+qyS6J23rW1wpQ+MMXsqoXNxZAqi9zlABrcK84jv4FT0wjHNIqDTpJyIhkay1mxUAFiUkkErdvQ5KCOtoRrMNyfYOvCsLEAASf8wIQe6ZUCaBo9smC9HbKWjPXcMIyvpxktExNo4XzA5N+TiSwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moN0N9AohXo6kI25Abl/whL3aL6xWbMk0+iw4AQavBA=;
 b=WOnIWTi0D+baL9TKf/u4lYtsk5hL8+UMBlPbtjYEpU3UCknpZ/691k5896uYeu2ABftAtdEj6lzbCpcFtTs35j6TzVwUvZcHxeIPlJMgR9hBYaIICE8A6uYZO8Gu/lGChbmEVtSJe8fc5DEC6W90nRBdC1JECEOlRJG3voeNq2SSJjaZgRpy5xfL52WNurPklKaN9oI+S+kwmDdp4+F0wrVvrmRr8j931erzZahI2nKWaHYxZIxgA2NqwXgfTGj3Ts/wcgwmEP1r0Ozs3XX7xtbwoani7hpGjx8G5TvDvCyWpzFoV9lLdsAxFydoaEQD+kPYk3E6CLE9q0lc8/Tauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moN0N9AohXo6kI25Abl/whL3aL6xWbMk0+iw4AQavBA=;
 b=mk2Xg5M+12K0fpGJ8/uxCuvkcE94CV2pxXuBQjBCCXAPcyUQ/9VwDY5ZL47CMB1z7Qg0XetpJpigwFinCYRZkcTmpmMHSzbif8I7+avAB7DuBhIJtJ7CLBbJtfxrIcp9OVTSF78raslhXvFDsPls/Ysie7pR7fIhaQWHfyKNVqw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5034.namprd10.prod.outlook.com (2603:10b6:610:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:50:42 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cc63:ba5d:5d87:579a%4]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:50:42 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, ardb@kernel.org,
        jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        nayna@linux.ibm.com, zohar@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v9 6/8] efi/mokvar: move up init order
Date:   Wed,  5 Jan 2022 18:50:10 -0500
Message-Id: <20220105235012.2497118-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220105235012.2497118-1-eric.snowberg@oracle.com>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0095.namprd05.prod.outlook.com
 (2603:10b6:803:22::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 529425aa-4282-4166-4488-08d9d0a62f27
X-MS-TrafficTypeDiagnostic: CH0PR10MB5034:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB503459E5EE48BF3EA9C7891D874B9@CH0PR10MB5034.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6pCyBKg7TZMV4kC2kVehoAH04dMRIFtQ7yyKGCjbgsEKz8JQWbsdhBvIgPUM30utHTmWb1yokCJN7piqggnQVP2lAAu+ixhAv+2rgA7mDHAZbxVxpGxYNOL2sVktQLWdFLq5t8Xjometmt9PEuPw0DdFGBQn8KfEjAlpWzRUucTXnmxnsfbi1M5o5oHFrNR6ICmg91SFDIUOerJNhVp4FbUboI1RwgDWsuazcRLXUG7z88CnS7RkFnAZJNtyujO+q+YD+xBCN53qgi5wtBm69H1DuOhAl6LZDhomnHq1A/Y22+q68o2wJdZArzajrC2ox8JDtjvYPrQORw29CTclZkdUk+F47oVvIsFOu8Nm1cliiXSqcuznmaZPU0oVjnoju0wTggc0J6hKzlmknVJevdQXpLJieUUbUPWQhI/kyNNf8epvWcaoZ6b1EuclAFEetS5eYGQ/prvyDhQq/TgmmYEHeS56IurTrHf+pMCSv741+WKZJsGbAe5czwaJc5HNnJPbUHOwqLXRQ1fLHCQ9D6wyREBhv58ASIaDSohgqgRL54HzX2ockHTt+85PWS+Oypd5Y+zIx9g9gy9EbXi4fn7oDxJojjznTYd3SLZaG0kM7CrOOyWo614I4h0GQcTn9BjONR5rk+pISJsh7uJugHDtHU0GkSpd6aYe1FTjnmz+lwhYcqQwFA9I4EMu9s09So0O9AiwCp/gwtINrWMXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(8676002)(316002)(2906002)(66556008)(6506007)(508600001)(8936002)(66476007)(52116002)(2616005)(86362001)(4744005)(66946007)(4326008)(7416002)(36756003)(38100700002)(107886003)(6666004)(44832011)(26005)(6486002)(5660300002)(83380400001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtaFpKpdlrX3FZibBANviyAgrsqQlZfKF5RMo/2hsosfyGRa7XJnB2k5DXqn?=
 =?us-ascii?Q?AVi8RkkisPBIEuCXy6fjW6l/CwfAFfiICynJ5TejujF8uYQDu5xMemErWzy3?=
 =?us-ascii?Q?wkirSlG8LH8XvaBojJNOOZHMqKV8kkIwl2Bp/EfiXNKopHCCXEUa8V8KHdMu?=
 =?us-ascii?Q?Y7dKaeKIIcRbIoiMHsvAk7guVqXRbYDnCDdorwpPYy/odCgXaGjwIMuYrLwp?=
 =?us-ascii?Q?RBFaOjuuPVI3z/GreJB//kBuRsxBFnoEf9QpPgaJbjPlE0d+fAXquCpjq/oB?=
 =?us-ascii?Q?i6NXlrcX5hGZbH+FcQusKX30namftNJ59yBD8qN5wyREg2r5TQ+pb+iOLZ0N?=
 =?us-ascii?Q?ROk4OAq+4F39jkGxlZC8+dSaVjqNZoILdeanS+TQqgygFQQOSh5arvZ5bBm5?=
 =?us-ascii?Q?8qNB9LyB/L1xpZL+GKvFThVbaXDqKAAKVuLPdwEjGFWzeHWbROKcPCWrLwHF?=
 =?us-ascii?Q?NB80bGwvnMQ5g0JIAFWw6TgwQlQuCV7kZJyp69pQMqzRhcMosXY/AARO4Jff?=
 =?us-ascii?Q?utgroGtQv6lo4hCMD1ul+VRmHg7AGq+zISafYx+lV4pXSTZE0bZue/+YND6o?=
 =?us-ascii?Q?8p9XtPFMZd+ZQ9gmuMMjptw4tAa4QYlFrftqzBfwXJdPG09B4ijqORSrFfxD?=
 =?us-ascii?Q?7NrGx39j8ZGHmI4idhaCuIDYnD+hH2lm3IDhbRIIqU30Je508ZmzZ2mp6OWy?=
 =?us-ascii?Q?s8OmidLffgoSvcN7HX+Dabg2gGQQgX54weJzJu5fO0jq6jv4qe/eHuJoSloh?=
 =?us-ascii?Q?VHJMmFKqhEbBmJjgVUpXVCV4ieV7MHHUMRn9IzrYf09eUiGy6MiZ5dlU547+?=
 =?us-ascii?Q?bQ1Rv+qIV9aOCI1M2OY78kkn2fRDq59xtt89lwVrsTvasTPMtsIUbw5YCXGx?=
 =?us-ascii?Q?AqAFAgBQBKbBD+VxbLn/cBDLOHg9fXGYag4zVscrfuVCO8xmnd0kYryZAF0X?=
 =?us-ascii?Q?laMAVAdXdq+OyqTb2v+Cj0L0DXqy7ZzDyFcmz8AeuzQ7O64KxjwHwwMc55qf?=
 =?us-ascii?Q?iwNWhZDgCChQU57cdDeu5nFYi6xWakrs2AsGeQVhQypiGBkJzLqaO9lzVSVN?=
 =?us-ascii?Q?vxHdGKLN7a9kIqi+1eUs3nrsD81jT5GltxZtbampSyt1NxLpijyssyJnihFs?=
 =?us-ascii?Q?AU4DbZKbnAwAb1PJ4Xkn/Nt1KnNi9yELBoEkiDG5WJkYX0DMIM5iH+8cOWgE?=
 =?us-ascii?Q?1fRFPFWgZhjcREK0JIWlw8vE/u8o5fjf0bB02n5Bx8lva625ABLoLwnBux0z?=
 =?us-ascii?Q?eCiAgMIYV035WPITitI02fQJreUIBYMhjt//9AG7aPBWObKANBlubAYIYJmH?=
 =?us-ascii?Q?YJ0frllOmAh7RjJewSP4L75fPbEhpm58t5C6zNwdjlJIt+/Mn6wefwKMwpaa?=
 =?us-ascii?Q?+QSvWIIpbgmx8u0/gPrilx7YiSq8KN6t4yum2+wH4l1iWEdbXKkUaonTibJ9?=
 =?us-ascii?Q?UTJZBe1OjNHXSEskZqJQD5NNgxsFRoIJCQOmOw7dEJ0hciysfPCrtYnoV9Lm?=
 =?us-ascii?Q?aHyLj7ezifjs2ATNpTHVonrpoC0ubxoC/c5tm2Tg4icg1eQgkBxdKEWs4KIO?=
 =?us-ascii?Q?DrHNt+Pi1IsAcG6JkorJFcV8gnNOwhrfWefGobDF+enw/V2PN//NTbbxJMkd?=
 =?us-ascii?Q?ge5S/ZT0gAEelxgqJFLB+JDLo0LVzq5GPD7Fkh5IQLrl+9nrmWjns+izd309?=
 =?us-ascii?Q?sGZZ/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529425aa-4282-4166-4488-08d9d0a62f27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:50:42.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUqR/EgvoJlquu4Xg2iu7YEv9kqA/+wrCpxvRfZjh1ugjI3ltBtuTWFsaRMJoijB2/4TXanBI2GwP2kOCVcf4APbYhnh4GvNgeWaXzb0h7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050150
X-Proofpoint-GUID: 6_ceHJItPutMruteO1WAwVdJHeZj1qc3
X-Proofpoint-ORIG-GUID: 6_ceHJItPutMruteO1WAwVdJHeZj1qc3
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move up the init order so it can be used by the new machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v7: Initial version
v9: Unmodified from v7
---
 drivers/firmware/efi/mokvar-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 38722d2009e2..5ed0602c2f75 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -359,4 +359,4 @@ static int __init efi_mokvar_sysfs_init(void)
 	}
 	return err;
 }
-device_initcall(efi_mokvar_sysfs_init);
+fs_initcall(efi_mokvar_sysfs_init);
-- 
2.18.4

