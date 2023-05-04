Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3C6F6E4E
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEDOyD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjEDOwt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091617A9A;
        Thu,  4 May 2023 07:51:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Df0Ri005132;
        Thu, 4 May 2023 14:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=prjLNVSR6dAOMw88eikONSMKuTErkrr7WA/ztMRk1yY=;
 b=t+PIPnr8GEYpEsOTHURjY89m3PDqk6iI31sWqjidt2oJ7VPNtWw6f6Ssnm9aXLcT+3aK
 FbRDiv3NvKCOS4B9DHeRGUQFSbOC1qYaxHsI6GwIFQmnmtPzeJMJRfMDJvXX/f3RmN08
 9SSrW5j6bsES4FawnlWPhQcHUeb6fo+2yCmkZE3qkv0zO1jZaxU+62gXGnhoKAs/vjEb
 EktBVSZxRT9jhCpTc67Q9xl6hzkocJCV17wyVoVNZV/3o1e2K+Tk8ZGcJch9HdvFdvNX
 3Pkj2EtTBciiu83ZQIslg2WFm9Y5Lzo1KhPdAYD3a3q3HeNHds/9ZLLKBHDB3pBjRKPY ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1t1yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344E0Vox009941;
        Thu, 4 May 2023 14:51:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp93k9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2WJiNDDJCY4yk+Xtxfi6GDSSJXntgdWQVE2jkzDKzFqvcivpk+6K5Rd3CA6rnYThmA8iCKGGO0O7a1jiWYUyY5aF8yjHadS4bQ61RxHtF02Tp5o4bs3r+xOPsGkaM4QLfpiAEN8qUGIPO6+mUu1gDfviT6ecUAiHTSF1tpUaHoTRg3yE1qhfO8V+nlvy0pIBFy2dMCZQz8BEOyYADgz37BOcqx6jaFxz94lcPAZO8pEJvlpUhI9R5OaqQH4yi/Jw82clhjbbZaCWpFByMyxv7qOKBhZVmkEeKAPFhF3JpwTa4ZUSexfpJzlO1noKch72halCOvClMyeapC7Z/OMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prjLNVSR6dAOMw88eikONSMKuTErkrr7WA/ztMRk1yY=;
 b=XOqSxbyDRJUaX3/71i+wFGCFDM6HvC3WovwUQnvuiAwzYpQxpUBApP7C1CtrsLNGmiPdXbgq6kUtek5UFJbjJZaanW0/RzLBKrrDKEU3NTS5+y173XBOxVaswaVMYG8eUUV5mA4Kv6SBqEhVHwnpXPulvDjVTo7l2yzV/BkaaclKl99R1fQmqnoLYaSE4vQ7I3bfvdseRyA03ppLTFwnQIqwqxPm3x1KTt0BrgaNd8pC8zen5JuEcvxNpXcuN9AjjwkdsSuPRh5VztrSDtgwacp1MY6Aei1fH1p2Qm9I3PFnue7DUtj9kFmvR+iQRl27xwQNHMm1erfCEzOluAVaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prjLNVSR6dAOMw88eikONSMKuTErkrr7WA/ztMRk1yY=;
 b=UjdxYXkn4HQoZlMjdO1aqoJgSI3Y7g+vfzudJQMKGNsWPyxHkSzm/UsAaeXWHS1XeFg3+n/mcZCL4wk2dmuHFQVCfVQFqK5gTfD/mLDx81c4ZvW5hc3dNkYqDvWih+u6e3y1xRPYyBP/uSfJeT735HkhapUqh+ZNL0Lb0APXsMo=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:22 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:22 +0000
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
Subject: [PATCH v6 14/14] x86: EFI stub DRTM launch support for Secure Launch
Date:   Thu,  4 May 2023 14:50:23 +0000
Message-Id: <20230504145023.835096-15-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:8:54::17) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a4c8b4-4e7b-419b-4903-08db4caf073a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuDmj6nqgIcQYvm03sYFTjppvQSaf2d/EEL/qbLWVb7PW/sc9ssP7rQ6UDkgM+A5L/NvjS0nrPpNE0T7ErRAMXv2wCsTMRnzME8Pohj/W1DDf5EJZLtGY+ihKk/kIyhaFXMvwUr4D2SLvzNPgsAjc1X0bk7bADAk5E/V5gZ08F3c/ss9oATziGrCkHkG4SiX4LYPU0sN/FHcKadHvG/bdJZz7dbbnJ0kYLlSrYu7b/eBY3oH+qGYmhanDPsOTFAxcVsJbVtfQmCarQyL3tR6i61LFIUs16UR6dbDTDwi4hkqepx0RnC18Q0awg37/q/xRiBoxkN3KCCFmETMC++cF3RcH4sYf6vRhDY0urQ9Jz1yOyobO6GVVauojV1TWjeeRHAxxiIko568cd8AbIU5COFydMHp9ZD4XQmPMuxJHXcNAneltS95kMm6JQVT7sbxYTxelPzsO+RYW7yOb4SlZ1bfqVrzPc02hm8VQs1ehLyVFKzyyLbF4qE+njC7nyUnSXD49WJ4DeI1fi7y+GAXedxXmR4R1l5ZABZmJqmN3QM/Dz77YKM0KSY5BNFdJjFR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGOOZVkps6WEpIGYnC65/zaTMDaN4Heh4t6NYQ/zCOaN5MCP+LHI1rOEFgBp?=
 =?us-ascii?Q?FN9lvx5kB8/x/xAutKarqHg1+/PAR8UuQOt6YtMHaAiYXxqvNydnsFBB9rZ7?=
 =?us-ascii?Q?77BOXByJYKjwUXEeu/aiSCfAxhiZVxFGBYTEvf3PytJArYaxrFcR0U6VKOeK?=
 =?us-ascii?Q?mOFBVsjfKeVHFcn5aa3hfezsnABlx0OKGQlOxmDgjUTMTz6QgIJGbcZLatdO?=
 =?us-ascii?Q?nLRAt5K7/Hv7QmHgdcCXOq53GbgUhB20ayF1Hbd9kTIiOY89lL2hmMcKNQwg?=
 =?us-ascii?Q?M1DsdRmmg4zbhZPH22ToICSUDvA3skpNFQwWJKlKRLPpdTy/BhA1urXPRbkM?=
 =?us-ascii?Q?qN5sKEmJHVgjyDBvAlgAISRlohIl2W6uST/E4iULl6+4PiZATeE9A7/4xxDA?=
 =?us-ascii?Q?RBhiISIvFgR6+kXPz/6aNoPJHL2n5JmT2V6tH4nzDwQZdVY9jZWq/VnRKZOs?=
 =?us-ascii?Q?6lPBhIZpTxrnwBBmZDRDNFu5OxfLYnovU5qXQAMBSey84NAXDlclTHTHTnFv?=
 =?us-ascii?Q?Vb9lADN0nUhoJbYsXfWtltYyoPLUuZre1yRfSpUHjGPF+qyHB5Hhv2vnk1k0?=
 =?us-ascii?Q?yPVbgtV83gq9UfEvBrIeg0cb7/YdUyudJUoNv+2G6WKDQP0dzB+z7OvtxUL8?=
 =?us-ascii?Q?ykFQmYoOR5dUAFJBCn1ECo3lWUd0zhFjcYYMvtMVTOmynxZooNXnrpECDgz0?=
 =?us-ascii?Q?CB/F+cbBHkl63SPRhE2zA0DxRsd/qUtFGx59ZnXVDoxcHlr7TQMosVgk/uwM?=
 =?us-ascii?Q?sQJw0BCVsny+aP4y/PAatGiEyMKwCbHBdlZ3sjuJAp6536y/p/JxT1NrcorQ?=
 =?us-ascii?Q?SdlCMnQpmmzHDr1KErweD2KBETgGQoe4tDBS9lThW1nlX35hVzAul+k02amb?=
 =?us-ascii?Q?5luX6Jg/W4h4cfKunspxKrQr/4mKrW8w0XoYQ+fXxd628JPBLYfl25+4PsHj?=
 =?us-ascii?Q?LbokMASwz5aTcMv2U3Lg4fc/B9WpsRVJVIve0eaM1rPAKtHhlP3qDOPVxqZD?=
 =?us-ascii?Q?xZsPd90E+6DU/tjkBBpYy5l06jvCcmRYRq2wkdxm881Ooi325uFys0DI0/m+?=
 =?us-ascii?Q?Q/IKD4j1w5To/mMzOZJUZUPQoRb132Imw5Im+79inEoFkmFCy6SGQx/x7kmH?=
 =?us-ascii?Q?yg7R0iP5YMRGTpY9jnDmh7M7Wr7XtnGMQ7a6i1H5IYBPEWeo7t7d78DixUee?=
 =?us-ascii?Q?o2+S7/oXJKMPRiHx1WfKNMRI+6YwWbcf5i6/K7S7gSfxzxWoMu9M1DCf/3XK?=
 =?us-ascii?Q?FMTxE7udCu7n6A7Id1X/YJcrhSw7t2T/tI738oQhixIGGje2t+R+jgfKk71a?=
 =?us-ascii?Q?I9GAYX7UItGizTlAXfUfnS1ciQAZAxPqSVIpuLRa/p6Xk3BokhIhNqG/YG/8?=
 =?us-ascii?Q?xDfdWWk6FM+GTDXrWY8bc1b0WTi890p3iW2TG/hTG6lGh8b9Mmg58qP1yFrU?=
 =?us-ascii?Q?LjLf+i8hLdu+ue95Enda/X3UoQxyWj/Sf9RxH5I0DNeQhuaUYs0k6MZatwQR?=
 =?us-ascii?Q?09u/odRZ00EwC8XMYQjNIy+8sdDC5dNs0XnNHY6RcahtoRKK/n5noxGS6gHc?=
 =?us-ascii?Q?b3Uyw6H2Ybxjy9TqusFgQqwIujdZxOB/qVq/Fzp8ALYXBWsVV0/J0kzu8b6r?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LUMy3fYl3da9RPmSHlS8ipNijnniN4VLbcuTHhofnSaVxwrD7fKk4cC6CseP?=
 =?us-ascii?Q?b3preh3ISt3lxoxheNM4BFBIOOv8cUNVBKtNdftkIZkkoRYuqOF4abJaLvLp?=
 =?us-ascii?Q?G/OQd13n6tWAMJjl+Fx5ed8wJkXlvD1vQu2uBAxCcoBI2Bf2Z8kz61Sufrjt?=
 =?us-ascii?Q?gVXfHiPXn/ihL7sHDXn24ehSp67yN4knBIBGAG7BAnY3yV2flOB7k/pkcIiL?=
 =?us-ascii?Q?f1ihpBoT0pZ4TREsi/G44MKnqSM5Cp9+rPwVegufQeUPsAN6NjNMnutLqUpg?=
 =?us-ascii?Q?ie1MM5OmsZ+sfS0n33MTGz4QNEIjZkkLdgpzt1IZpPGA5rF/5ONvuizJOibh?=
 =?us-ascii?Q?ibvAQkID2L9kHtBgvxrg6fAIkzt9j6OAiTCSaUghvpQ5EEBsBWo6LyeBl1ju?=
 =?us-ascii?Q?0Llh+JfrALcYXoP+BG1XFnexPIkUb6SDcY9wOloQ2HGpIivxLpE1ry7YovLH?=
 =?us-ascii?Q?EsjJRxOwTShWfvLN0qgYQnnyaZKug2a+FkCsZ+pGJautnd7eN/gKM+CN3Qzt?=
 =?us-ascii?Q?nj0pl3KvQ2zFrAhaHLj3uysAuYpAa4XXtLBtv5ylLMW6EfQXyE3dwF96tQU3?=
 =?us-ascii?Q?dtB9VuiyWygUZtzaoZcYjjsVRmFQjNQctbU92KXPzjgcDeb1ev3vUXbIYuKk?=
 =?us-ascii?Q?uk/gqtq5rAUToxB1ZLmDfIYZEMWUKBXxq5gguA67eAvjog59z3qxXQjOUrlv?=
 =?us-ascii?Q?W9XjMoCblYvxx1np8VRj6sjUW3JnOhPkqFOKo3rXOvjHTS9I6RHgFD/OflGc?=
 =?us-ascii?Q?67/SHDpRCkO//d3G9oPzK8ortLuDyGzvkcdvxEM/k/gTBsIQAKZnK36tmy2x?=
 =?us-ascii?Q?7cq2ITIdMdBTYfDKmzxQ+i/EN5I5EwCoMzkwY6u4W1fIulxxT4rFYPljvrYk?=
 =?us-ascii?Q?a522o8i+Hv3cyEAV1lFFV/f5RStdiEJa4olKiNvT87Of2krQlDj310OOpXsY?=
 =?us-ascii?Q?MmeMXfALZCtVdoMBfh/KPzZTxnJQ65sh1bGz90zTzKsxLL/4BumgIQHcfijI?=
 =?us-ascii?Q?N6utOi9IJGTt+uQPwZzfgDUeyPNv6v4DA66AdlkYLi1kkV4vXbpr1KfuVmHg?=
 =?us-ascii?Q?69hfDKXSi7OZUfr8iG0Yu/22/PGk0qNHa3CHpq9cc52+ow9dLvkfLX6TWtKi?=
 =?us-ascii?Q?A4NVtq8KJp0+HMrf/MlpB234qcH+mMDOm4jf3rtSJOzta8oIwFvWVrTW0cCC?=
 =?us-ascii?Q?GBGS2WiReRY9QfQoM89JjufN9PYZ7TeDfyDuh6MFuiya2iQyNrlu+TMlW4Ef?=
 =?us-ascii?Q?os23R3VVJSdHOR/Dimz8J9HE8LZtLC/lWmQg+WztXrOxNfL0cfnBMriMLSLI?=
 =?us-ascii?Q?1Gw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a4c8b4-4e7b-419b-4903-08db4caf073a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:22.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kikEKwlCuEj6sNryAdxq3fhhNt81/sChIPAn0pGct0bQok8C4CJXmVLebX9SkhutWMDDKB0DOd7jvBuU8fQpCVFc/axkH9/iTK9UNohToDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: -4mzUxzJefsVg-j_gdUmpxZ5vCPAfefP
X-Proofpoint-ORIG-GUID: -4mzUxzJefsVg-j_gdUmpxZ5vCPAfefP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This support allows the DRTM launch to be initiated after and EFI stub
launch of the Linux kernel is done. This is accomplished by providing
a handler to jump to when a Secure Launch is in progress.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 55 +++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31..66ff922 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -9,6 +9,7 @@
 #include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/stddef.h>
+#include <linux/slr_table.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -760,6 +761,57 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
+static void efi_secure_launch(struct boot_params *boot_params)
+{
+	struct slr_entry_uefi_config *uefi_config;
+	struct slr_uefi_cfg_entry *uefi_entry;
+	struct slr_entry_dl_info *dlinfo;
+	efi_guid_t guid = SLR_TABLE_GUID;
+	struct slr_table *slrt;
+	u64 memmap_hi;
+	void *table;
+	u8 buf[64] = {0};
+
+	table = get_efi_config_table(guid);
+
+	/*
+	 * The presence of this table indicated a Secure Launch
+	 * is being requested.
+	 */
+	if (!table)
+		return;
+
+	slrt = (struct slr_table *)table;
+
+	if (slrt->magic != SLR_TABLE_MAGIC)
+		return;
+
+	/* Add config information to measure the UEFI memory map */
+	uefi_config = (struct slr_entry_uefi_config *)buf;
+	uefi_config->hdr.tag = SLR_ENTRY_UEFI_CONFIG;
+	uefi_config->hdr.size = sizeof(*uefi_config) + sizeof(*uefi_entry);
+	uefi_config->revision = SLR_UEFI_CONFIG_REVISION;
+	uefi_config->nr_entries = 1;
+	uefi_entry = (struct slr_uefi_cfg_entry *)(buf + sizeof(*uefi_config));
+	uefi_entry->pcr = 18;
+	uefi_entry->cfg = boot_params->efi_info.efi_memmap;
+	memmap_hi = boot_params->efi_info.efi_memmap_hi;
+	uefi_entry->cfg |= memmap_hi << 32;
+	uefi_entry->size = boot_params->efi_info.efi_memmap_size;
+	memcpy(&uefi_entry->evt_info[0], "Measured UEFI memory map",
+		strlen("Measured UEFI memory map"));
+
+	if (slr_add_entry(slrt, (struct slr_entry_hdr *)uefi_config))
+		return;
+
+	/* Jump through DL stub to initiate Secure Launch */
+	dlinfo = (struct slr_entry_dl_info *)
+		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+
+	asm volatile ("jmp *%%rax"
+		      : : "a" (dlinfo->dl_handler), "D" (&dlinfo->bl_context));
+}
+
 /*
  * On success, we return the address of startup_32, which has potentially been
  * relocated by efi_relocate_kernel.
@@ -905,6 +957,9 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
+	/* If a secure launch is in progress, this never returns */
+	efi_secure_launch(boot_params);
+
 	return bzimage_addr;
 fail:
 	efi_err("efi_main() failed!\n");
-- 
1.8.3.1

