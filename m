Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB04B501D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Feb 2022 13:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiBNMaH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Feb 2022 07:30:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiBNMaG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Feb 2022 07:30:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9A49FBA;
        Mon, 14 Feb 2022 04:29:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EB2NAk028540;
        Mon, 14 Feb 2022 12:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YwSB9zQlxMDxJqfMdnaEwdczij6rRS3zJozgH2AnoDE=;
 b=QYQJOt4Sw0kb/7UYBJi3MTv/DjgPK0huHM3vDB0ouoyUU4LkNvAjwIl6I1yeNfO97MZx
 aQMSX6QHIyfYss51GeOJpxT8KY9+fqiRXsA9eIUglx4uHHA5U/ALPZQSkmwUx+NpJugs
 NPt3fvQjGYqx2vgui1l+POGpkz2adGAeLPom/fK55cGIEW24UfQ+l0AvHyOpV2J/Jszh
 F+hh6kMYnvKgGJkIn2GCkh9k7t8P58nkTeas6OCBfxvZK1XYEJRMUXWW0KRDmkMnMuXE
 uGx+GPDGR6Nr5LCORvESRIr8Vposfw1W2x8XJZHMpyM81ZY2Y7v9h4id6sCdEM8n8TTr kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g14ar0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:28:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECGPaK082741;
        Mon, 14 Feb 2022 12:28:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3030.oracle.com with ESMTP id 3e620vvtpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6GaEn64z9rvKVPP1Rb+4hb2YJ9QCh3COLTfaNYxGzeXmCcYKRrrSt57WKGU3o+mS4aCozqermRPvzEOzGqN5TOTs98iKtNje5ghABHqdDSh+UeaeQqzthU2v4Ml1CwLpAAMv5zO6tFLC1At1GXTCh9rErsKLTicqULUiD90eQN143HRn0D/FBw8PH5BA8F1FvkfjEj+XhLILLVirUP/f9H38i+pCglg8BPaMmb+g6dB+Co5yzTD1JV3Af3h/jw9zmkvIyeO2EnpMOgQXDl2iG7opk8zvuQNmUXATeYrYRzDb8EIIyaT7BwBr33KyQnAmdUesIL4NYm4oFrkvsOtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwSB9zQlxMDxJqfMdnaEwdczij6rRS3zJozgH2AnoDE=;
 b=F6ppIL3Y65vHVCfZTKqAzfgrzuOimH/FtktGlloc5KeH7HJ3wK9haYIvjroMwBDE8FxXpF1ZoIFvfSYnNFfKb96jk4UrAMJMKvVE8tsrvvbLJPeP/PL2FO8k/ZpkW/oQUL746m+M5KuBo9Dv+F3J3WkmvAVShbnRBy9Q75WRRqlQ2ZyCreCsRLcLzfc23hgO2W2KhsVZ7T5jNGkM2z5T99Tc/eeSNDZofUldjgFc6lnPD8B9tuyCwli4usoAOl8X8037H76KCY7bK9g6dBpqjfVKgSioBNYQJCoLehhFQN5/MIQN6NFeYWqZZ6UIJhmPRCij6bEziMLqkf9FlqRdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwSB9zQlxMDxJqfMdnaEwdczij6rRS3zJozgH2AnoDE=;
 b=amvamSFjQ4kIzo93vHcuqYj21bxptg5lfA+yW+k80kfANOrjWrLbcY7KIWfsmXB0bxaPJm56atl5XcUv7ZQSyhK8eKQMaPXdXZvmaI0E1DpIdffFVpv88PyaQRZZln/1F+ZNxBtKOJSrcqv1vuaqlTzzCDn6Vq3RTwTWhPcc0yU=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by CH2PR10MB4037.namprd10.prod.outlook.com (2603:10b6:610:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 12:28:24 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::e1b9:9813:d7a8:8d30%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:28:24 +0000
From:   Darren Kenny <darren.kenny@oracle.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v8 14/17] KEYS: link machine trusted keys to
 secondary_trusted_keys
In-Reply-To: <20211124044124.998170-15-eric.snowberg@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-15-eric.snowberg@oracle.com>
Date:   Mon, 14 Feb 2022 12:28:20 +0000
Message-ID: <m2fsoltyxn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DB6PR0301CA0083.eurprd03.prod.outlook.com
 (2603:10a6:6:30::30) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ff91230-5184-4f03-f9af-08d9efb57eba
X-MS-TrafficTypeDiagnostic: CH2PR10MB4037:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB403720E08618AB37F5D593DEF4339@CH2PR10MB4037.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oX+Na/l3QbdajLJ1c38N88woUo1tKz16DWVVK92TS6IrTrEeEnXPW8S3L0mopBBEbDdPWZ9m3iCVW0aub+5pum0/VAGI+9ObD0Gt11IZ8TaF7RoD4fEeVeHNmYFfT4rTjOnd4V0ZYhedCoj+4DXIQKIQ+3p0G76AzI6mz6YMHxKwDFk/NyYGyNYwXwt1vXfJ12U3p08UzorEsotQv4bwks7ac2UyGHBXMpCwwg8WGuvGdoxsYhSToMknNMp+gf8yaQVKaHfAc91o6nu5nL9/ffnaWqo78P/+/ALE6kBvJ+sHydFyBczu86Mrr8Zjq3Imkl1ikFMufyIC8ioaZhzcUq7Lc7prSraTVoEGXPOOLiHEyEkIVFuJpEQBTFi82o8s0WE77jE23GxVY56JUENUmKEg8XpeMfWrpISGcl4KlUEh8n7phJmFwFWdiCWzJVw2khVmFemCoiEDAQOTx/ahWVdzfV/poin/BFLMjkSzA5BWNuMkc/g6xjWTUw5ztzTlbClxq7OyYPT5ZOkb2LqHvEdD0OxyF0RAera+5QIR2HBnjf7fHMHK8nkqoUaoTXP2H5UFH2n5ci1R2bpIBRM27uMEmNLCnERQiJIjZxWZjc/9EUGrMjuQbHKhTX9//zcM12GQQYziccizhjYpHI1fFXo3gthNFkAFpbP56XIX8IYzSQk20gIIUnW0ATfRcZ/yDO6htlDTXofDmxofdWB8M6yCZeLVNC/hfglaPEHxOx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5138.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(508600001)(6486002)(6666004)(86362001)(6512007)(38100700002)(5660300002)(44832011)(186003)(2906002)(2616005)(36756003)(107886003)(4001150100001)(4326008)(8676002)(66476007)(66556008)(52116002)(921005)(66946007)(38350700002)(8936002)(26005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TdHcZ0SQtAzyceMe7I7pVcyiIFWLchBqXcl+jy43b4TxJ9PL6n0eeQSGkP1i?=
 =?us-ascii?Q?hHZDTT5BRCH5Ts2XbK5uEWsc3LqDv+n66lJ/m/a6MdHEI7BCoDsgOoaLVRb4?=
 =?us-ascii?Q?ccynhjQMYp9tQAEPRMFpep65WbI+LwnuWryT2a085Sc7dC6GR/UVlGv+3USC?=
 =?us-ascii?Q?oPdLTGMmmhCijc9Tr9y/drsIPoUcc+0GcNueo9icpE7VgC0ENElvX7zplk2W?=
 =?us-ascii?Q?Q3cx2PohqnPyAk7W1vSq5K70UqVVu6uQumnbkwpCtgXM3ch3u6mLeTzYI7GB?=
 =?us-ascii?Q?xPyY4U106c0KqZRE0qFae0Y0t0T9VaHEHdi5grpt6bxvmjgiTZ8SC0OirVPs?=
 =?us-ascii?Q?XlFaI2ysF2LU8yV1HBQf6VQp3+zTtzWy9YeGx+74MqXRYP8B60o9HDcB5b9Y?=
 =?us-ascii?Q?7lcFlzs+0YCoYlBEPdFC7rufMXafLbJzjOHVQuG7BFhG22t6zwu7fZVVepr1?=
 =?us-ascii?Q?wi/5LCY0iNS+EcNhzbw79tzwsu9uvkeldmVeksVf6hU0Ggw41nyD1Df1wm/U?=
 =?us-ascii?Q?sppeA6SoAndkn8ckBfXDYVrj1h6p7Scnl9/OxRWif/yqzze8Qdt+mYxIXLgl?=
 =?us-ascii?Q?aES1QUfyaW2RfkSXKj+M56KD3WaaahqrLNTnZYQ4Wa6krOyIJuwNChSMhHlu?=
 =?us-ascii?Q?YcLpF3Pnp1U5+pFPfEq6Fl5W0+XbmZuhogmwxCp+N5O396bPh54Dzd2UDC6N?=
 =?us-ascii?Q?dswXQqJ0uzhtv8CVP3DccNYyuOpEfPwKmSbKzgy+fm31LCdOgg6JVYfCMU8X?=
 =?us-ascii?Q?pcS8L9TlbK4//11BPZp/Lt/R8kJbxZvKHAm/97cthBtZtarKfJmwBz2qbn3N?=
 =?us-ascii?Q?nQKBt7qxsuKsEGjXvsbWP2+tTZunJhqyskVgtd6poHjjNQBYTad0gEm973ct?=
 =?us-ascii?Q?NFHJbjMld6dOXm23G0jPV/P0BHwWn2u/yiXDm3SKFe51yRLi3o2PQU5qu1DW?=
 =?us-ascii?Q?VeIljNQowHTa23vW+ZBSnmF+B5hWuY5skl09OBK4MoUdvphrV3zbz9q25v48?=
 =?us-ascii?Q?vRruL7+VNu/pcJg5yu8RZrq1HylD7AOiUnx6CwhkMaJBwJoPGG2RE7rdfKSo?=
 =?us-ascii?Q?uI43JontmgvUbIx1qE5tQfSNorRbUcqPkukpyAEeA5Mp/OswIKlm5LTT9gln?=
 =?us-ascii?Q?qAJ2pbKVz0ZXYJihG1jhHAE+ygAaQa1CxjZwCqXkFMVxasmTNOgTrj9xEjaq?=
 =?us-ascii?Q?YdZOdyTbGx6oukYL2STKMP6EhABNAVv3HLEwjS3GD26SxOVKZW/D1C0zGPaN?=
 =?us-ascii?Q?UxLTHsNkkaxRWH7pHPEZOFYUB1NfHF+0uY9n8wVLkScS9+/BYrPCpJLUhYQf?=
 =?us-ascii?Q?/vM0TkYQoxf1KeJFcq0tl4vuAVRSNotzz8isyfaopPHFNShZaQM4Ze+MzMyM?=
 =?us-ascii?Q?lI1DFnFrBP06eRWUWckj0mo/qsjPHuNpxUsG+/tzmM4BhkhMlLExC5ym+ybN?=
 =?us-ascii?Q?cKpCxQUuH4l5M6Epx9qOBKkb+7j+nAnyU2CKeIEWmPBLDugYUn31GVpQWZUo?=
 =?us-ascii?Q?BMVskabdMqXrNJLH3BZ6ZAd5n2d9zK/5Cag0iQlSDItbXp9mslEsY+UW0G9v?=
 =?us-ascii?Q?qOuXE3BWEQqaFmnx2YPkBuVVmDkEiXGAChTxnQ1J7W9a4xwl7s8s7ziP+c3k?=
 =?us-ascii?Q?CrpeC4RfOhOLHG+ZgKZCZwo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff91230-5184-4f03-f9af-08d9efb57eba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:28:24.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLUGAjILhussJZ1l0qhRcBWPjt+ISDxXd4H1KzHGePTFehjrnrj+v2uKQeAMywW8wBfzVE1Api8zq8BHoVGCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4037
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140075
X-Proofpoint-GUID: -IKUjZHweQwef8SvlR8FXj4_5JXbIojt
X-Proofpoint-ORIG-GUID: -IKUjZHweQwef8SvlR8FXj4_5JXbIojt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tuesday, 2021-11-23 at 23:41:21 -05, Eric Snowberg wrote:
> Allow the .machine keyring to be linked to the secondary_trusted_keys.
> After the link is created, keys contained in the .machine keyring will
> automatically be searched when searching secondary_trusted_keys.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
> v3: Initial version
> v4: Unmodified from v3
> v5: Rename to machine keyring
> v7: Unmodified from v5
> v8: Change patch subject name, code unmodified from v7
> ---
>  certs/system_keyring.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 07f410918e62..463f676857f0 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -101,6 +101,9 @@ static __init struct key_restriction *get_secondary_restriction(void)
>  void __init set_machine_trusted_keys(struct key *keyring)
>  {
>  	machine_trusted_keys = keyring;
> +
> +	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
> +		panic("Can't link (machine) trusted keyrings\n");
>  }
>  
>  /**
> -- 
> 2.18.4
