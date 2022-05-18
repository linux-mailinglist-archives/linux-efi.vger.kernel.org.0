Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B930C52E405
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 06:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbiETEuK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 00:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiETEuI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 00:50:08 -0400
X-Greylist: delayed 1075 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:50:04 PDT
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02hn2245.outbound.protection.partner.outlook.cn [139.219.17.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012AD14AC97;
        Thu, 19 May 2022 21:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1rWE2Jhd6Otm5Gaq0C6nSLgp/T8Xo9MyUQHC/Q8suakzabFkZZwfpl5SR2PcxVDbwDWIRvUtA6WVB7znPniLzgsJOFrmdx41p5XcUjrV21LuI1L2/UHDT2Gvvk3VWHltL/MqZsF9T+aqSqUhtzduM2b9fP2aEc+KlKYFesmgHEa3GBzcY3q4pHUk4Cin3b5jQPwiPM14SzyrAWrat6x/77XAdoLuUwImJxzcGwpOLSrwmnl1FmqLdYKzJxEmjSfGj8sOSxRpfwwWXlYKiTr33KKANruHw8b9iDryk3yRQQY40UdmG3GmQKzazg7vcr/kOnwl1nWq6xy9mKd1V3RdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=GghB3cINsFfXh5MwIX+mcz74uhda5rzhfc0U+R82CgPh/47K8po9EMR2dtXJOG2d8awCUA248oB+ITBSYI5kmSxhsv48dLRZi1Yk9rUaJis3ZgAgtZS5UNtP+HzYNG1Nivg8dpxW4YqG6Zo2yecdmzC9CnrWaXDe877SqvL68xiiwzJnmpel+HigNab0ceOJ7NPuStG+FNLfbKj5mPUM5kM++PgSvAar2FUdVl+0NPhTqFcTIC1MVduE5yVnZv68uoUjaB/zjKxz9QU2kauFEue/saPoLQ25fZSkxiL33eYJl/KzJm/tqDhxnlB2FhaCXLpoJEpjJAhcX9e7ecE8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=XaYxrIPK8OhXYd/k7se0Lqdb9L47LX44KAdQvYUYhHHDTCf7ToZSe1gQf5HQhkaEfbIVUH0w1vZ7eAY98jlre+Umumvi3k04Oha86FIRMWla7VDCl+yo++3ecoXnvtKM/6mhtWByRdu/5yVo2ghGra1dE079+k6KxLCtIbeSf4UUKtbmFH/uh2RtmWFpkYJsBz8CrGs+qCDG1g7uJCRghGzDGfbrAWGZqT4M2GXsDPtRKDbaPD20L0xLTv+2vInu/niJL/6p0F6xTK1d8lp9t0PzU7v+VI+R3mQxOuV8ZW4QzzbXa7dZPMskp32VDZ6XKYMG4fBErGyC7uvcRFv6Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0895.CHNPR01.prod.partner.outlook.cn (10.43.109.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:17:17 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:17:17 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:05 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0008.CHNPR01.prod.partner.outlook.cn
 (10.43.34.148) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB06232C3157CCCE095B64268E89D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5d448b-62a5-4b8e-a1f9-08da39141791
X-MS-TrafficTypeDiagnostic: SHXPR01MB0895:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB08950BE87265C20F3997AE3489D39@SHXPR01MB0895.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?PaTthnhQyWOs8BGlYdQ+auWVnvG3vTkKwMa6IzNkkx2J7D49X439XgDgqP?=
 =?iso-8859-1?Q?NCHzNYHCe7WjIV+kXQYc6r7bIP56Y8zMYupEAvEg0QpiL+nHUzOoDVBDJG?=
 =?iso-8859-1?Q?ay8Dq2pQA+04pgZ9XDfnICi2r0ihjJGOlMno50/ak4Cio7QpxoLpBVbh63?=
 =?iso-8859-1?Q?UTahrq70eybyJLF8i8pnC7wcMWNEnrNF60e70IQZsiXx3ouId3LxQU6v97?=
 =?iso-8859-1?Q?aYvo68wdhg8gjuNSq8FvFZT0fMFPvu88YiO1N5isTd+SsReozFCTmYvCg7?=
 =?iso-8859-1?Q?9yf+Qvnd3X+T0VTaz7beAShwryye7dBsJ45n7liMy/60tKZR9ZwQWJW6II?=
 =?iso-8859-1?Q?13Uv2s3pvco1QUz2LXAOnevs9ZoZnMNcX1Oi72i6UBEo9pT5q57PDLVgS/?=
 =?iso-8859-1?Q?CopIWzsaXoxSvH+b0LpKOmw6w3OgWVZ7yX+bH7oTdx7qVBZvlNCieBymhY?=
 =?iso-8859-1?Q?VY9+8ErzFCc03GbBZ8N4/Sja7/cwi5TRC1Zo0ckLxMmdnpJ6IzcUXQVGpV?=
 =?iso-8859-1?Q?BqglE1auXYszGTumMyQ0Y0Zl4vSSBKpHd2wp5xdrAOMhWvP2FTeUq0TfPD?=
 =?iso-8859-1?Q?+5Z3h0uWErE7dJozwLd8oOcYbTYmIHycK6D862Sxvg7NBAxn/NI7HA4nTv?=
 =?iso-8859-1?Q?L2IsyCG+cPpNZ+XUbzXF0u0MZ0uvV3poqRXDgM5VYBnhgzektG/IYLBMjB?=
 =?iso-8859-1?Q?A68d1a0okjmIbcb3rZVjGh/SKEuA31pgzESQm40hTVqtCoE0xsEUKoYyMl?=
 =?iso-8859-1?Q?8plyqM8WsZVs2dLLU35fLXYAVmpWl8T3ba6NMOu7uB4UdKy56mOdw8ItoQ?=
 =?iso-8859-1?Q?W3r6+TWeS27vC05tCn3zz+LlxgALqHaEUKwo/iZqcuAqwF8/uAS42YPysv?=
 =?iso-8859-1?Q?jC+nDuVPpxwjscCAuxtxSQVQSsCa896XauBWQkl9chtEuma0Br7gmm2BP3?=
 =?iso-8859-1?Q?68oOkxLhMDGRvRWyiKRILSzZisIzSOitVvQCIAe7DgUmHjeCU04/Tfishl?=
 =?iso-8859-1?Q?ulnnpuuwe3aejn6PA/Zl7Da2IqIjDVMN4lnI/syFFM01jlJBMr5dd/SGDA?=
 =?iso-8859-1?Q?oQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(558084003)(33656002)(6666004)(40180700001)(40160700002)(7366002)(7416002)(7406005)(66556008)(66476007)(66946007)(6862004)(8676002)(508600001)(2906002)(19618925003)(7116003)(52116002)(8936002)(7696005)(26005)(4270600006)(9686003)(186003)(55016003)(3480700007)(38350700002)(6200100001)(86362001)(38100700002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yf3rvu/7FvwKixqeKwcmfUa1F8BG5GvlabVUESKT5PcgtaGOyVMXo9dZo2?=
 =?iso-8859-1?Q?iI5dBbbkPtt2w9yhwnEQmImYb694xKZWSrkOE+hAnoUaSmc6F82aHbdKhi?=
 =?iso-8859-1?Q?xgvSijr7d9KnkIG4pUgI6z3zXnNWWck41Ks6ynl0jtUW6ZSJEDcgctwBSy?=
 =?iso-8859-1?Q?RalgkOfQX2jlOURCYpCYZqPIXO5ROkqScEmr1xLT6NW7yKRu9KGzm7xesJ?=
 =?iso-8859-1?Q?aXURhcuSWKO7+lNitS34mPKgkyi/VUyT3VaA8CO9L57I5EK8gso5OveT7E?=
 =?iso-8859-1?Q?Oip0Mt2VTr75HQH+BtMVXNPPPT/TOOhgzu+wGXyx1nHfc/+N4QR+9YRH6E?=
 =?iso-8859-1?Q?aQ+roc4sbXegJGg41ak3g8GG2pDYqKvgr0wB8G8xjKuVXQElpjRt4mVrnm?=
 =?iso-8859-1?Q?juVaIhw2sI/sa6CVbE9O8AkTSQxWfzdGh3Xy9qPMgyCqUxCF+Ior39/Zm8?=
 =?iso-8859-1?Q?1K9WWVO6LD8c7bXmbvmA7Xftse5blL9xHyaT54g3YX9Ov6GGyFciUBjiC4?=
 =?iso-8859-1?Q?rYd7LvNPTsIB7CDLUdefCr0JA3IdL7VfREs5HDlHoKZQmIbQafU5JWX/Qc?=
 =?iso-8859-1?Q?nVUqj/KqbVNwr9UdfmB6IGNcGx5DecQxUMcQsXs6C4kBatcviz5ih7Kmns?=
 =?iso-8859-1?Q?gsKP64rcmaXjANRbif1499dlsErDuAWDh8cGdpwZFGlnIF5882tUeUsgiY?=
 =?iso-8859-1?Q?Iy2zsiONhWzjnd93ob9upaD9sAa4+oSVzKGwgdEkPJTwg9WMITpypWGN6X?=
 =?iso-8859-1?Q?2EE8qNSEl8urfeQgMmfu/DHSMDUB0HL0igEGWRa2SMbxUqLSojYCQe9awS?=
 =?iso-8859-1?Q?vVqRXciTAz+3puTs/g0+a+77lI2Y5V1joKRsXekjTLV7hDTYFDDmZjOiTR?=
 =?iso-8859-1?Q?SFfUtT6Ib0/qwlDSHMJ4gkxgpCxQIZTm/lcLgoM1DQOl7bX5AVbKallqnV?=
 =?iso-8859-1?Q?UBoenc0Gj3LM38BX8FV4/uNKb0/IR1ed4wQEbpusjfIKLI0kjjPDZjaVZP?=
 =?iso-8859-1?Q?4I+fNcaou8H0LZIo8hiJMX3nt8s83v8+BwwqVLPfHbfPUv8GvTck7sg6Mm?=
 =?iso-8859-1?Q?flN9Ul7daEcim3rmrdCqRx3s8IxaIC5vNrlRfeTBkntMIqofsu1OFyjh4G?=
 =?iso-8859-1?Q?yaENbjY+Yf2qSno5l23Sg4U4JpkhOEWcoDRhPC5KKj4u407V2t9DeCGXUZ?=
 =?iso-8859-1?Q?qzF7yWMw3DDvgHbXUf6yXOvJuNaZBTC+H6i0vsKgyxVuVMY8khTDhVLm3+?=
 =?iso-8859-1?Q?y8rd//MFO75UeINRYx8wXhCP2hXO14vypihBwjrDcQhfxG6lXfQYiAD74T?=
 =?iso-8859-1?Q?mBBNa6h3q6Z0e90ooRyRwT272PZvU37dMgneV3R5no4TAVZu2QCWq+/ip0?=
 =?iso-8859-1?Q?CgV8nRkT+5fzL342Tyxwhh8RWewOWMu40LJkoebVyJIDaqYUAx78E3nQoM?=
 =?iso-8859-1?Q?VNcZCXd36dQsIj0V/+TIvf+XhwKi8sRA9EkK20TKQ38Y/UC6XalbEwTSL8?=
 =?iso-8859-1?Q?GutUbjxcxbrUbpzQxYiMe0rUCMo9cpcFdgrpL9Zu8QpP74sp3OZe/Fjosr?=
 =?iso-8859-1?Q?cyHBXpoM0DXgBL0zRlg+kHAV6Flnxp0TP5TuMIzbhaqhkc/yvU7bJFcfQn?=
 =?iso-8859-1?Q?d9S3Yps9AHgXUYJB/2CVL4CuhiKSILDBug+syG3tSIBrag4SflJyMiVSpq?=
 =?iso-8859-1?Q?qiwy0/ixUx7hAK85e3+dV+zoEfPcldbUd1Jm+ZNe1Vt/+0Junbik1lfb8U?=
 =?iso-8859-1?Q?JqXQ=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5d448b-62a5-4b8e-a1f9-08da39141791
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:28.5458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mavfURWzuWeQ/xlmJBV4t8ePrHzu9o+A1cm6LqcLjQMDIhKLgvUm8IkBzkUwLs1xaWcE+5DzOCKOOFxcc5dIw6sj5O512+t2B/zByJ6rNFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0895
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,FORGED_SPF_HELO,KHOP_HELO_FCRDNS,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Can you do a job with me?
