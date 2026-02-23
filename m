Return-Path: <linux-efi+bounces-6196-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDcOOYr4m2mp+QMAu9opvQ
	(envelope-from <linux-efi+bounces-6196-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 07:49:46 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 518601725C0
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 07:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9957301BC3B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D623446AF;
	Mon, 23 Feb 2026 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dQHEzmjk"
X-Original-To: linux-efi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD772343203;
	Mon, 23 Feb 2026 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771829384; cv=fail; b=L4haCzKfD6PeDdgeRfZY0vJtUKECnhmKfpAPDqlZ3v/4dGzl7uKdNj0WU7zFzWKUIkVvBvVJLunIYePt64evl88GwIvvthgxOtjOWXAHAFC+AmxxIOFMkRNurChw0v4gJg/8QBX6Fzx+ULSkDv1IZKJEW/f/MXzaL3Lq4HGyZ8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771829384; c=relaxed/simple;
	bh=NpQntnsS1xsSlda0jUZHg2nYSpr1zAoSN++RYaLq9E4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fy/595DYmnpOAu4FdjdLbdt3L2RDNLAHpcNEuGO7PwgHg6UYUNi2EJrGYUT0BpOReNjHgT81CcZS4vzl96fW98DHOoQxUp+zfpNrxr7rWHlKmSoc3cCejBRUIntufaQCYyxxDGog4Gv0v602EkVq4ZIUMCpDqx/4alrZyQnVILw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dQHEzmjk; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBHbMvxgEaH72H2WXA9P4i3acpystuIysvgm8dBgvY95/OELcLwHMAXnOHkR1U1XndhQ0lljKUTeCr6Y/zQvdegTQ9IM+wTI1d6nn101cDcf0iPTjwTFLloRGY4SSP2uPtXLab4/k3pKQSfBr1+LKOnrwVXC7Dm7NW6tKAgt6Gw4eTTGyfCz4hqgSQBEnAJPY3KV18mQ0K+ZB8F/T4IdNGER4Qvu2MLYdk0VD51a8HpMoQqwgX9uijhKBwoXdMDo/5MR0P9IrbATrXVPq0atzFdhlwTHGTWv8UT4jM+a8Ag32Xd0snYjL6YRZqISDvQzc9lrOrN0KHBZ7LSK+ihC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll339zIuhr4YDTEU3feLGV/LGFV62qbLrXtIitT34gA=;
 b=bcpncFTIf3rlLlEMKthp7c7e3KE6JhSCKaQAubuhU9xg/8PLAbVMEEIVirZvMHqdOmlln5AW5odMpCylyhTmIi/xAPdU3PAN/Cou9VU6I722nPplh/U642+TMivJXt5w+k2s0ynOYOm8ZWSR3iJUtaKoZfhNFn3eNtTmfOYoxL8HWckUL0e94kBVL7JsNsuUNktpULtFwv+3EC07DuuOqdOX/X2ksdoB2d6bH6myM6Ft9W7T40iLrFgScw9cemUQLlJKVQ7ot0KT0bokJUaJZ9Lm371SzhD0D1+tMsBJy05tADZIyq3omaKSwHg3IeK0AUAhuu5FiN9ZWlMJdnPhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll339zIuhr4YDTEU3feLGV/LGFV62qbLrXtIitT34gA=;
 b=dQHEzmjkWhE6N3aGfgwVun9uPdG8gEwffk5MSUevCbuL3mYsoBIGPbEMPyLVGC7EZ1PdyFVcEgTwwhGmZ07YJ14MYOKUxh+Z5/zXM7gwQior0iUfnJRY0WUvswyxwNet1XWfQ+zaeXrfDj0JusoU5XwQJknBNH2opFY6sWnxY2uR3ngg6qcj/v5/j1PyDIt0DvUAyMd4urJEb3Ct0vEm2mHfTcL1NfcFlTdWTOrglJUHwq52Occ14jBOE9YYo2O46+YnOh4vhDz1lzsH9ZixGlj/+oAwT9N4/4SsQ3VwLoxBFzMGpIvomD/DUb0YQDsuFQRwl+7yNn75FuolQGgKrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:49:39 +0000
Received: from SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34]) by SJ2PR12MB7917.namprd12.prod.outlook.com
 ([fe80::6e3c:d0e2:fc8b:4e34%6]) with mapi id 15.20.9632.010; Mon, 23 Feb 2026
 06:49:39 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: ardb@kernel.org
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] efi/cper: Add NVIDIA CPER section support
Date: Mon, 23 Feb 2026 14:49:15 +0800
Message-ID: <20260223064924.6449-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:820:d::9) To SJ2PR12MB7917.namprd12.prod.outlook.com
 (2603:10b6:a03:4c7::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7917:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: d619a4d3-1918-4e0f-975a-08de72a7b719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2BXYSDsS6upZ/HzgbkeotbcAzB2rYjunLShY8oIoGhdEQ0n0ACj0t05i1pEd?=
 =?us-ascii?Q?G64sZB0cYf//TOLIuDNoSgY1kpbLKpltDloJqWpgM+uktuuCxY112EiR1m6z?=
 =?us-ascii?Q?FRH75NGOtXqPZYNgo4VFs2vlngsp+5wEJMOG7cMoNUxL1UKDN7cbvq3HvSvK?=
 =?us-ascii?Q?GFLKuV5xdFSzSlHZkMLRenh2HLReQ6ljmXfDRjxS6uqZx6uKfnLxXh/UsS1/?=
 =?us-ascii?Q?Hkw7vZipEUtetMfhXYGFGyhCx06+0tNry3EekURdboRjm9Gv5OXDPhbvvkiv?=
 =?us-ascii?Q?0AjlV/aTqYx29gbZNp5VyzzhT0qgxYn7/c+2BbgDMGqPEVnbvv6SPiBZyAKi?=
 =?us-ascii?Q?U7TVf4aTDJUFU27Jlc+Ou6VTZ+O57RmsuoseMQtzO6Wz16xT07iEMDQbz11R?=
 =?us-ascii?Q?TrwArpRvWR1JT75h5JEGC6ssG6/yw/zHD0EzVxvwCmEdQ312zRquaVt9R2iq?=
 =?us-ascii?Q?i6QLhXoOw5KBvqbc/CXbesCxqCmM/LCFzI5jC49EVyrKWaELQZwvyDET8BgO?=
 =?us-ascii?Q?MM4EQzRC8Te1bl6uyMY5ktkk8njDiyOExhI3KdT4nHovr11ElqqtE1jnPo4T?=
 =?us-ascii?Q?70iuQSUb4AeEg1ex2Y2ddLg/p18QXjGGeaBT2SLrUTzZ9TQKjeoC1kf/6PHP?=
 =?us-ascii?Q?PZdmHDhbIEORkVdlzQMA3mNqo1vasDv8ew82QaSgavQ2gN51u+WtrXuoiWhE?=
 =?us-ascii?Q?9eOfC4/6ZxZdSDPs7MUGKQCYXNTzKz+umd411jg6xe5MDOIpjFfgyJnmDNj7?=
 =?us-ascii?Q?KE4bC93XLZO/HzQ6ATzQE4ubaaeHzsD4Um4L/ZFc9ffKWxfZJQ+QxnoD1EOI?=
 =?us-ascii?Q?3VW9lcGGCyVCufDuBxNeYphyBn2Q3xgw8odIfnUgAGsCOVDWQeW6wDhJDrj6?=
 =?us-ascii?Q?4A8++WF+FcASTluds06/OZPEgy1G3ku245UHudxpI1d+gwBIOPi0M+wq8EYo?=
 =?us-ascii?Q?b9ZcFcDkk/MFwHUptwzLwicqwdO5djGzwxeMKf33F5RJ5DfFMsbU8K/PhA+V?=
 =?us-ascii?Q?+A0lHjIOeRw/P2VXgVnH/5Lg5MGWzWXp3p8OK2JCDd9Zb+piVG2E7UPsp2a8?=
 =?us-ascii?Q?4Mz0QuBWp3GqN8DbllLh4NStLJzWnOVPm9w4Cynd9DH82dM1wEdB7KF3NNXS?=
 =?us-ascii?Q?0irqPK0P+F85zkFo6W1lnfz2baQR5b/iOdAsRU9XmcyTOKKk85j3VJDDejSU?=
 =?us-ascii?Q?E+Ws2wtcbFikGisgkCcNxd97U1pfN/ylbRyfdLivNQl2q5kzBsMjaXqqK2Et?=
 =?us-ascii?Q?11TomIiRyelIepJfWrAOwhOd0yaa+pfGw0D2LZ+XQK8AHdBnwJA6cIOLI3SV?=
 =?us-ascii?Q?Mxbbnon/Fo+w4KTrDmlixADsLvEEer4i7V5T5ZWkIksMN0AzLYsNzcn33V1M?=
 =?us-ascii?Q?fsnZRoiFkz0kS1dSAg7SWHNIGwwdQfpwQEaJlRyV+dJcuV3snQaK+YXGlFiY?=
 =?us-ascii?Q?Kg8JS6Mf7Z62/rGsy8M5JTssw7AOeTRMIC1ncW7aNqqE9gZsYRVvVJhI2T+H?=
 =?us-ascii?Q?3aBaJvUlUUaZlllIUh1d8k3UVFTzjXGYwP4Qtd5eFCqKANG2wP0nTxMCDl7d?=
 =?us-ascii?Q?wnidz5O+etEh9S9JSgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8syoEb3lgWZl5WRT+Fe+yOCD47MysRjV9wm0vNwnJZWIIilvheicfOzx4uV?=
 =?us-ascii?Q?NAmD5KeXNd3VF+Xw1BeNA7cSLAhEyiZIIgdNSXUSWKnkqeLLyZEIVp6bGDqL?=
 =?us-ascii?Q?vp+id3uR/YlYeUJDWA8r6eS5c4bbjlMQIBIuR3vhvheKR65ZRvPL3L416Hip?=
 =?us-ascii?Q?4T85rxsWRo47IT0QW3YwA8eN/ihyQA4OKxCkUoxGqdmCwAiONzsvSfp1zY2A?=
 =?us-ascii?Q?gHgQAAlp3bUNyY4wmiuognJ+kVdIzC3GOAHefDPSX7brGEIsdVE78qhLL5Ql?=
 =?us-ascii?Q?UmLXAd9Ndi0r2drwwIZVccq5zbQq2Gu7mMlrTafMvCqb9yn7e2B86IsSQzRT?=
 =?us-ascii?Q?2vSD4sf0pySNP02H1CGmssEd7HTtOD+UbL5VXkWJuut6VLilK8xaZHoBw51Z?=
 =?us-ascii?Q?MBKauqXPHoOmf3qKt8w9nfZzM0YuKL0eFpwoDSX+0D1pJFbOHMNyVdXuG8L6?=
 =?us-ascii?Q?HOwHcvAEHABKcCjBpLw5fV6lAAh/7Wgl3eq3GOiz+W8k7q6Boxlcg1OYjwfY?=
 =?us-ascii?Q?WY63oKR5pwj/3SEU4Hq2AILe0uW4PPqL16NKW2xwG0g2VxAPLkEOJAXHz6AK?=
 =?us-ascii?Q?sg6AFCXRbqJ2PEay8wiF89qUgsrErFXwNRqynSEwi3kDFRn1dbylD7v7mXGR?=
 =?us-ascii?Q?vOuz8asZy9o5mqmycrraHiEft2KGW3HhvQpy4F2Z89IkqH1wp0KE9sAUul56?=
 =?us-ascii?Q?qVxSwjjVqI+Ctn1AMgOQ+gtEQJqdHhEHewP5y/bp0dDorE9Pf84s5rOPzE3O?=
 =?us-ascii?Q?h4oElhFK+i6tyr9prlIBaKHH9bInEuXFIcf+XaPutgJUPG+oy8/8FXOuMZgG?=
 =?us-ascii?Q?7/S/WanrKTLBIAnugEGaOlh+jneJ//wMUfqMcvfTjg6XATCbhuSypH2Xlmj5?=
 =?us-ascii?Q?ylB5Qqe5245hF05t++1EOsA88rIeMHTr3TE1/YXacuESKJsGx+sTGUkJ7pw8?=
 =?us-ascii?Q?f2ccfedb8CY9/bYbuiJ3ZtK9kfNyfktrWoz3tmcUBpxqLzKwzIopB4HFD1Zm?=
 =?us-ascii?Q?pTkHGhDFqUxW2AJWushko4DB01iqT4j2r0kltc8Esa8al7rjNNAYaxv9PoGf?=
 =?us-ascii?Q?sIyuaWdGrdWdgjuBcjKtHboK5Dx3JEsQrKmVI0VwEo3nlrdhs8wdDG5XlVMK?=
 =?us-ascii?Q?IX3THBxIpverqIKdLUS/TjD2vRQDMx1ngo2tNFUYIsIXhdR11ZoYT5mFMrWU?=
 =?us-ascii?Q?i8/k39ue87WVz/WsYGzGbWrAWWyC+zojASgfvyv1IeNPuKZflCq0NWbiLgHH?=
 =?us-ascii?Q?pURV2htRoF8OJQH+lKBHxolIghcejHOLiyyS+Lq7cNDypCkJGHYIULItJ1Oy?=
 =?us-ascii?Q?00ZgkpSUEo3chOg10KZMQ7fPTkCVPJntBEP0dWaOHJm+qq4TQe+SA5FsuuHg?=
 =?us-ascii?Q?AszKNkPuNWhahfwd3qZGoBv9Lep/dFd8O1TJzWKMwOblemGBcw5BUWmucVyq?=
 =?us-ascii?Q?ZKQb6Z9VMb8eRzMLfhshc1IjDFHueTDtFLKjI7/XWwG6PjC/G6NyysK/teAI?=
 =?us-ascii?Q?Ex4uAUYSXY6jdkOocg0v04fB6JzGXBUcJiN3JZBnAEsmXQX43JcIiUGd0H92?=
 =?us-ascii?Q?XMyYBIfNVesdXEWVaKRYBS/qFfY3aRSmY0QWGkTZdwInCu1mzsSnUaPKCoAt?=
 =?us-ascii?Q?E1VRZhRzs9e0U8e7wn2bnUSubzGF3xuLLonhGl92CM1o15wGdXgIprFk/cxs?=
 =?us-ascii?Q?mccxh69S7UqNcPCAFomXL1iDLIKk2f7T49gU3ZqH4X+H13duyke713ze0nmt?=
 =?us-ascii?Q?Nc9t2lSNrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d619a4d3-1918-4e0f-975a-08de72a7b719
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:49:39.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zm6459iJU6fNVhQeoV3kDOQ1I12JEwGNM2sPy+DuNgmblTcIyE41WORfMWerCw2VDHKru3aKpbk/rTg7UleJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6196-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaihengf@nvidia.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 518601725C0
X-Rspamd-Action: no action

Add support for decoding NVIDIA-specific error sections in UEFI CPER
records. NVIDIA hardware generates vendor-specific CPER sections
containing error signatures and diagnostic register dumps. This
implementation decodes these sections and prints error details to the
kernel log.

The NVIDIA CPER section contains a fixed header with error metadata
(signature, error type, severity, socket) followed by variable-length
register address-value pairs for hardware diagnostics.

This work is based on libcper [0].

Example output:
Hardware error from APEI Generic Hardware Error Source: 816
event severity: info
 imprecise tstamp: 2025-11-17 07:57:38
 Error 0, type: info
  section_type: NVIDIA, error_data_length: 224
  signature: HSS-IDLE
  error_type: 0
  error_instance: 0
  severity: 0
  socket: 255
  number_regs: 12
  instance_base: 0x0000000000000000
  register[0]: address=0x0000000004f10008 value=0x0000000000002019
  register[1]: address=0x0000000000000000 value=0x0000000000000000

[0] https://github.com/openbmc/libcper/commit/683e055061ce
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/firmware/efi/Kconfig       | 16 ++++++
 drivers/firmware/efi/Makefile      |  1 +
 drivers/firmware/efi/cper-nvidia.c | 79 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper-nvidia.h | 33 +++++++++++++
 drivers/firmware/efi/cper.c        |  3 ++
 include/linux/cper.h               |  4 ++
 6 files changed, 136 insertions(+)
 create mode 100644 drivers/firmware/efi/cper-nvidia.c
 create mode 100644 drivers/firmware/efi/cper-nvidia.h

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 29e0729299f5..ed1f53b8e878 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -329,6 +329,22 @@ config UEFI_CPER_X86
 	depends on UEFI_CPER && X86
 	default y
 
+config UEFI_CPER_NVIDIA
+	bool "UEFI CPER NVIDIA support"
+	depends on UEFI_CPER
+	help
+	  This option enables support for decoding NVIDIA-specific error
+	  sections in UEFI Common Platform Error Records (CPER). These
+	  sections contain additional diagnostic information for errors
+	  occurring in NVIDIA hardware such as GPUs, switches, and other
+	  devices.
+
+	  The NVIDIA CPER sections include error signatures (e.g., PCIe-DPC,
+	  DCC-ECC, GPU-STATUS) and diagnostic registers that provide detailed
+	  information about hardware errors for debugging and analysis.
+
+	  If unsure, say N.
+
 config TEE_STMM_EFI
 	tristate "TEE-based EFI runtime variable service driver"
 	depends on EFI && OPTEE
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 8efbcf699e4f..a571b6086860 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -42,5 +42,6 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_UEFI_CPER_NVIDIA)		+= cper-nvidia.o
 obj-$(CONFIG_UNACCEPTED_MEMORY)		+= unaccepted_memory.o
 obj-$(CONFIG_TEE_STMM_EFI)		+= stmm/tee_stmm_efi.o
diff --git a/drivers/firmware/efi/cper-nvidia.c b/drivers/firmware/efi/cper-nvidia.c
new file mode 100644
index 000000000000..8f96318c8e95
--- /dev/null
+++ b/drivers/firmware/efi/cper-nvidia.c
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UEFI Common Platform Error Record (CPER) support for NVIDIA sections
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cper.h>
+#include <linux/unaligned.h>
+#include <acpi/ghes.h>
+#include "cper-nvidia.h"
+
+static void cper_print_nvidia_error(const char *pfx,
+				    const struct cper_sec_nvidia *nvidia_err,
+				    size_t error_data_length)
+{
+	int i;
+	const u8 *reg_data;
+	size_t min_size;
+
+	printk("%s""signature: %.16s\n", pfx, nvidia_err->signature);
+	printk("%s""error_type: %u\n", pfx, le16_to_cpu(nvidia_err->error_type));
+	printk("%s""error_instance: %u\n", pfx, le16_to_cpu(nvidia_err->error_instance));
+	printk("%s""severity: %u\n", pfx, nvidia_err->severity);
+	printk("%s""socket: %u\n", pfx, nvidia_err->socket);
+	printk("%s""number_regs: %u\n", pfx, nvidia_err->number_regs);
+	printk("%s""instance_base: 0x%016llx\n", pfx,
+	       (unsigned long long)le64_to_cpu(nvidia_err->instance_base));
+
+	if (nvidia_err->number_regs == 0)
+		return;
+
+	/*
+	 * Validate that all registers fit within the error_data_length.
+	 * Each register pair is 16 bytes (two u64s).
+	 */
+	min_size = sizeof(*nvidia_err) + (nvidia_err->number_regs * 16);
+	if (error_data_length < min_size) {
+		printk("%s""NVIDIA: Invalid number_regs %u (section size %zu, need %zu)\n",
+		       pfx, nvidia_err->number_regs, error_data_length, min_size);
+		return;
+	}
+
+	/*
+	 * Registers are stored as address-value pairs immediately
+	 * following the fixed header. Each pair is two little-endian u64s.
+	 */
+	reg_data = (const u8 *)(nvidia_err + 1);
+	for (i = 0; i < nvidia_err->number_regs; i++) {
+		u64 addr = get_unaligned_le64(reg_data + i * 16);
+		u64 val = get_unaligned_le64(reg_data + i * 16 + 8);
+
+		printk("%s""register[%d]: address=0x%016llx value=0x%016llx\n",
+		       pfx, i, (unsigned long long)addr, (unsigned long long)val);
+	}
+}
+
+void cper_estatus_print_nvidia(const char *pfx,
+			       const struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_nvidia *nvidia_err;
+
+	nvidia_err = acpi_hest_get_payload((struct acpi_hest_generic_data *)gdata);
+	if (!nvidia_err) {
+		printk("%s""NVIDIA error: Failed to get payload\n", pfx);
+		return;
+	}
+
+	printk("%s""section_type: NVIDIA, error_data_length: %u\n", pfx, gdata->error_data_length);
+
+	if (gdata->error_data_length < sizeof(*nvidia_err)) {
+		printk("%s""NVIDIA error: Section too small (%u < %zu)\n",
+		       pfx, gdata->error_data_length, sizeof(*nvidia_err));
+		return;
+	}
+
+	cper_print_nvidia_error(pfx, nvidia_err, gdata->error_data_length);
+}
diff --git a/drivers/firmware/efi/cper-nvidia.h b/drivers/firmware/efi/cper-nvidia.h
new file mode 100644
index 000000000000..c489f8f05f0f
--- /dev/null
+++ b/drivers/firmware/efi/cper-nvidia.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * UEFI Common Platform Error Record (CPER) support for NVIDIA sections
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef LINUX_CPER_NVIDIA_H
+#define LINUX_CPER_NVIDIA_H
+
+#include <linux/cper.h>
+
+struct cper_sec_nvidia {
+	char signature[16];
+	__le16 error_type;
+	__le16 error_instance;
+	u8 severity;
+	u8 socket;
+	u8 number_regs;
+	u8 reserved;
+	__le64 instance_base;
+} __packed;
+
+#ifdef CONFIG_UEFI_CPER_NVIDIA
+struct acpi_hest_generic_data;
+void cper_estatus_print_nvidia(const char *pfx,
+			       const struct acpi_hest_generic_data *gdata);
+#else
+static inline void cper_estatus_print_nvidia(const char *pfx,
+					     const struct acpi_hest_generic_data *gdata) { }
+#endif
+
+#endif
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 06b4fdb59917..0b5216aaa8c4 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -26,6 +26,7 @@
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 #include <cxl/event.h>
+#include "cper-nvidia.h"
 
 /*
  * CPER record ID need to be unique even after reboot, because record
@@ -697,6 +698,8 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cxl_cper_print_prot_err(newpfx, prot_err);
 		else
 			goto err_section_too_small;
+	} else if (guid_equal(sec_type, &CPER_SEC_NVIDIA)) {
+		cper_estatus_print_nvidia(newpfx, gdata);
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 440b35e459e5..b5790e48fbef 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -224,6 +224,10 @@ enum {
 #define CPER_SEC_DMAR_IOMMU						\
 	GUID_INIT(0x036F84E1, 0x7F37, 0x428c, 0xA7, 0x9E, 0x57, 0x5F,	\
 		  0xDF, 0xAA, 0x84, 0xEC)
+/* NVIDIA Error Section */
+#define CPER_SEC_NVIDIA							\
+	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec, 0xbe, 0xa7, 0xcb, 0x3f,	\
+		  0xdb, 0x95, 0xc7, 0x86)
 
 #define CPER_PROC_VALID_TYPE			0x0001
 #define CPER_PROC_VALID_ISA			0x0002
-- 
2.43.0


