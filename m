Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2C6F6E40
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjEDOxR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjEDOwm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64846A67;
        Thu,  4 May 2023 07:51:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DiRQ2003750;
        Thu, 4 May 2023 14:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cimFUmMXPPdRRb9RVxT9QLutcTS3EKkjDzebxiqmfcg=;
 b=McXJRkEjlvnsxv+2DJJjxd0MjqZSFf7qnPGd8KYOtxwtDFmvt9HItGNVnBpr8xrc8DRs
 rwMHF65NA0ECKdHQ1nXae51TEKaG00eZ3svPpR7meC6q6NrSQmTnS5feRzfUT5XtDlqE
 kngJeqmaGckDNb/cF0oswfGrAk6EkAOZjM1vIAwSdq1j08Jm6sOxXjkppgaVKtNJ5D2Z
 WRc2EP0fBOSKriuMTOullKvWZjTOXTMoeUG0DRrz0yrJOEiiBAj6/bDpElIrYWAFgwhh
 3HjcwD5aFux3FIzjZO5RVqZuPJ7HXMKFdEoj4k3vSPvLHPzoVtMI7Duh6FqjDJTjV+lF uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1t1ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EPTTn020744;
        Thu, 4 May 2023 14:51:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8kes1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwFWz6tH9mLetnvgb6dbam4wBmM4NdZkw2maHcrwWL0uW7FVzCfam9y7DoXxmjunh2ephzqWal29Z0RTGzIcRVEAWhLeBy/vS1XAERHySfjVjnno1JjXbE7uVwxG1613H/LXlDGVNy1Moyg0kSjF5GwyOt6/U3j/xkTsCM3f3gcK5OsS/QbBzJ+d53nSUvQo0yJaZSf8CcdGk0MRibGYtMGwDKtLbe6iPt1twgFAy2x5i+HXfKvLXROYS2sY1h2EIRH0U+8hUUX9KcO/AyBMCHmUyRnW2ezjLkJa8QM84du8i9jmQH8iG6zDe3Ngum1cVlj9ESlTHFRX65+CpyMqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cimFUmMXPPdRRb9RVxT9QLutcTS3EKkjDzebxiqmfcg=;
 b=BFnSFIurzZ3LOvSlQ8ua0hn9Xu5ovZUoth53cgDnI+tOrwQq69HJSJFS7LD72WwqjRHaTPhfsqsEHywmxwUKkxZhqelbOV44Ar/ySFRRnN7LdKAKbzitUmby6rSFUKnkHmahTU/6MI95U9xtJANSC3iJUfXPyY8q/MY5KXBDt8PH7UEzUcHzQxdIs0RIaBbBTcjS3GJI9lpTnmfzNfOyiJtQcjrUtO3n2OMjcKuQ+eolVhHeChKJZhM/CUzyuRZ17rDI/V9wtgo+zxKcNxEu8dKQtdlUB3q74q5UxL78LWT6NBofRV18VbY/B97p7zQ7RTmSVTEOa+wAw6fGXQHxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cimFUmMXPPdRRb9RVxT9QLutcTS3EKkjDzebxiqmfcg=;
 b=Cuv+KeDpl296OxGbWhaqqRA4UF50vtq4H0xjIRGIDmMQH2Pb8bFIh4G6Go6BmjpGAujaNhE72c+2hJRwQTue8/dej3oBnGFJS9LQ7T9crXVwDOmdx6Emx1QCMek8IAlpny/aRqi+boY1/6ZMWU13x7HukVZIe9NILhRcMImN6Cw=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:20 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:20 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v6 13/14] tpm: Allow locality 2 to be set when initializing the TPM for Secure Launch
Date:   Thu,  4 May 2023 14:50:22 +0000
Message-Id: <20230504145023.835096-14-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: d623d4af-d2c3-4ab9-3649-08db4caf05fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3srn+YdUB3vA8jGNairQzob1WjUaUW0RYWCQLWLOpkv76bwqkOShkHOn2Fs8uFSgeSD6gEVFSFCoYwh4GgfUvAgUu6QSbcPJaXBdjiwSilA1/y4qL9aXPoONTTid3Y7j41NsnglS5tiQQBHc2O6B42fKQ4rXMevu5kKxyfTM+1g4luo9yIPoQNnVshHS0HmoogDW2+B1DROVvcvz08iU+o6xRabAAFYxUaJlLH4Za+oM9yQgB7HjlQRO2lkW7QYjWxP7EePejsR+AdsnRQEvpcQ6MTAH4QwIi6725ncENVdSjryDLrOH+FcBif8SQLCHVQ2aUEcLgASqLidG1joAdkQG3fBPTI8OsvUuMhx6J4MhSG/U5HlCR6kx+5yNRL3GI3dAi/ofTYZWzDcn/g8NHUUhsB9m+zx/y7gc+i0RG4uzPmGTDGgdcXcfH5UCvwdSv8Rw4Fdju+4K7VsWKGHoR8Teawv1qCaK3g72WkhGYFuCT8DmhuUe2Fz2Afkik9E+KSfJQcCl4zwfz5vea3+wbqLjvvcDSkI1l+4xPd1iaI1bVHnj4W1poh+coCi9pzF7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdK+R1kg4tTRJdf2KQLjGtIbUEPGWtNz/p+RSKxNiO/ZpjfOADNPBJw6KlRK?=
 =?us-ascii?Q?G4kKQaph7hHngx9NztGEeTAbtAImU6KpEcTfo0dUDxCvzsUCokLfeZ1CMdjW?=
 =?us-ascii?Q?SKfjtwe/NxcqOje3dJyBI92v7CkoJlKkitmMx0nWHn5F8hh2k1PUzZAjowb3?=
 =?us-ascii?Q?qdIxKspxRKp9MoTABkefO7d4PODxB1MwhhB6iUnsyIDZeknZrUsiCFpQdV/S?=
 =?us-ascii?Q?wbJ6Y4FQlOjUcWMJYGLAqx7UlyEQyKLIerpgViFfEmXhBQw211Ml+kAXEpye?=
 =?us-ascii?Q?WmspeSSNzdPrLnRKXGdm4ZpZhZtPwz1ZC0MFGLz/1T4nQUgDsM+aVVVDRZ+a?=
 =?us-ascii?Q?xOPBg1AI0Szzky/5Ef96ne01l1bXdm63CkFMCTENOeyMuKpbl/NKlxEgDCkG?=
 =?us-ascii?Q?qoCI0GhSNCvkXEq7fNJ0wVlsaelxZ/XBdtoNeZsWxy4RZNbabv36b4p8dfUp?=
 =?us-ascii?Q?/t9Sb/GWEvrNRcCvRI5WquwKg1ctxoPgLv1Di66uZOp8MB3nTh+z314OzMn7?=
 =?us-ascii?Q?G3sMR+EdoaR9qsMX97FtUzUIeYZBLPcFV+V+Ye6A7jDPiTn/ZYRU9LpCTUSK?=
 =?us-ascii?Q?E8gih1HvdjLK4QfaXr22FKGIg16lgTy713Y7WnOOpG7atBwN8Olhn95ctkzd?=
 =?us-ascii?Q?iM5sZsskv7yvG1Fo6mtxkFmNH9Ah58ljfoj6nuZAk2OxrtHG5kH25ImjPrIH?=
 =?us-ascii?Q?Sn9wo9TpUXNnPw3kl2tYXB1uZh0GwKp4oJyKtgUp3YjuOhJ8xK5allYYEm/H?=
 =?us-ascii?Q?741N8Z2Owrk/S37QDrLUZ6XdsqJkBFvi8kNMdn18wp9UN3WBUQiipFbyT5NS?=
 =?us-ascii?Q?Gn2oLDA3y6YEDEVPxcxot0ISArspXpbfgAz9RMiqJys7ozp5Y9knnYsssNMp?=
 =?us-ascii?Q?DQURKRlvvjunAEfz+SGxj5LnlT5hvNAoyeBSjuIusQrUZIJ+ILudjs3pcN0y?=
 =?us-ascii?Q?7xLLuAyvaXjCBW+73hQVLf1NgxyixYGB5TshbY5tt/zO7H47aWmAIkpDyCOj?=
 =?us-ascii?Q?+MHYfgnVsBkfrQ0I9M+J8uTGiP3HjSxZnefnmy6q5+1+5zA0qOTxnXXz+J9K?=
 =?us-ascii?Q?qEjZis7jlJuCFUszk1bVy0QeUOz9MMzz+gBphnbIH+vzMSmGk5uNFJZoKdyk?=
 =?us-ascii?Q?KzZLB96JhAhsHRu3b0ho7Pz9jm/Fev6Q4ckXHGISsvVpo3I3wlSV3fK25tl+?=
 =?us-ascii?Q?gcd/fV+bvR2Aie5fW36jAfbLAF7Cfcj3iADH1+5cZcE++SC6nnWe1Hc2Eq5Q?=
 =?us-ascii?Q?WuwuDhqG9rhQn2DoPjpeCIk8Ju4+VJXaLB0AwefABp1WKlXHB6I6VPp4w7yh?=
 =?us-ascii?Q?TOotgbwuJJRxEuCtrdC6aESyTtu2ujIUFtKsHTL/2MUTu1cIYiqvc/YOuwVY?=
 =?us-ascii?Q?wE9oZ0E6tOZ8fB3eTXWK+E+srKnKT9sdYsgecdZybxmwCH0OTsHl0uyto9Mo?=
 =?us-ascii?Q?etvbjeDgL5dv9XreOioicWkU4wURPFbyUucC9NHCqYFaonHuzUlGUEWxs3y1?=
 =?us-ascii?Q?AkN/al+KPKCN26mpA6TWRN2Ugu/NXY4NzMNGBCf9X3pUMYNwfMnlkBlpbrWV?=
 =?us-ascii?Q?swwTBHdrzTg+ql3P3KzduqxLTsKz8pBtgx5ToF4TaCy7u9zDsZXcZgY2mL19?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QP/auNSJ3WMt+OAHWuNFm49rsOBqfd6Uc0MH0YLK1BymBaJ0Uv1rJKWewfYD?=
 =?us-ascii?Q?zv4tYjNfjVHIzNGXC4XWWleIFF839hCfuoajAI1jfuEfCYoqD8k3GfdNUXUN?=
 =?us-ascii?Q?it9L8JXenFg8B0ZasV542jRa2MJRaJJhFc/5EOb8qM7M0kJ05u1mFLENd3Ye?=
 =?us-ascii?Q?XzDP5wBkzB+AIVhOUpglBHucIfS66FUrGvDJwld1YoqL9XDV0OqBYLnqEYnG?=
 =?us-ascii?Q?8u3UXHTvo8X7Fe/iVPf0p74bIw/wpPt5jzlczW+hFscUL/LT1LEpNl1I564/?=
 =?us-ascii?Q?oqLNmfAeWeo7fj6fRaKi5o49Yo+d+x17bZc7qxkJJTK7lUVEqMnsC8WGJGtK?=
 =?us-ascii?Q?KOKspMPdrWPp5mqMz6aCJJcGekh6F6K97WkdFqRB+JMRj1NiF7BZ2DoIEzd7?=
 =?us-ascii?Q?M2n8YZEmSEavneVmdMGjEufji++0I+irn4cdKWqYf0Rro1OBacY5Vwt9ObUH?=
 =?us-ascii?Q?vkRe8PtcbSg0BE5T5cStenDI7yMuKcQIjcfNKH8v6HXupL4/+/4Iz3B4RkRn?=
 =?us-ascii?Q?cTC2TLO/MtkV8v3pHRxbLSqavnB9SRx9WShdmIGP7fCeEJi4/vsNlVCnhjpd?=
 =?us-ascii?Q?DF9cFuqRWZkYmEfrZV4Y/zlcGDCrFKGeNRqhLNgJl89bmGKbIuKvPgIrQLqv?=
 =?us-ascii?Q?VLei7KWyT06FAZ48XDkplORZVGiLB+Wf4se+i/WfM2GLKIhcmG8c9rP8063Z?=
 =?us-ascii?Q?oFOETNvo/9qEAM7uB75MJR/XjUIoSZTFfou2mmCcbPYjBtm/oi4ZBPiGYMxt?=
 =?us-ascii?Q?2gZXlKzUNZbmv8vGscpsqlnZwG9+JH3k0Cyvah5rIvo+k5btEPjbNBV8G2yy?=
 =?us-ascii?Q?jFD+1nXu3/5NSkhcce2b6hZVI0GJJMHa1VLI2zotRM18IOA84l5Oc2kXU4HO?=
 =?us-ascii?Q?rLhNMM+ciJAS38ubUKtEZr3t1b3+Dr8G22TndfBICGUXn3U4AeqXR8aJ79RX?=
 =?us-ascii?Q?EoTp8kg2oPEN2oyZKngVMyniV/XBM42SPMetnOwLLipQ160BXUFhXeIRgIk9?=
 =?us-ascii?Q?f/lZuNVHPFab9IaSO5adAZHEP9uc2mtFs4qqBSK6bOkmtjO42SbvtE04MtIz?=
 =?us-ascii?Q?X3tqnz1mf+UUtzEueFxxado+4oEuBjnosqE0MDLtHXJ37LLZBErQyH1uwHWu?=
 =?us-ascii?Q?q0js0k9Oqp3D1RIh8mh1pXpfPpytncF9aezgCgye92Az7BatVn6YK1EtsdXb?=
 =?us-ascii?Q?DbN2t1TVOqXGb94e/WKn4dLqw1W4a5crzpUM4jikMiL3kBTuw4zwzfYwLVJO?=
 =?us-ascii?Q?XD8XBZk5ccRsbVtl3G7nDzXnVErsXGyzPVryvhq1U6f6n62z/Ooy5FdAVx+t?=
 =?us-ascii?Q?+Mk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d623d4af-d2c3-4ab9-3649-08db4caf05fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:20.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vrkSM7gJqyIlATbG+YsUcYajnfEA+NHk1lYGLkAYfAEP/f/mO4xspwaxyZNbjDKcK1ruN77P1xr1ZklRQ1me33qGiBTcL5MMnFM+siGcfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: TrJtrQHeL_WVFPcka0zpWrC_VBMY6cAg
X-Proofpoint-ORIG-GUID: TrJtrQHeL_WVFPcka0zpWrC_VBMY6cAg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 80aaa10..5dd2eed 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -34,12 +35,18 @@
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
+	int locality;
 	int rc;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		locality = 2;
+	else
+		locality = 0;
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1

