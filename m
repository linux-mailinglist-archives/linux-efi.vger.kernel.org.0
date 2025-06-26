Return-Path: <linux-efi+bounces-4016-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C826CAE9E6C
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 15:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE593AF1D4
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E57142E83;
	Thu, 26 Jun 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZfEjQLaj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q/GHw8oV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313D2F1FD0;
	Thu, 26 Jun 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943812; cv=fail; b=q75hoDsNybscZ1UTRankMwMzxA/XURTPFtyx1UKzUZU0eqI0E32nRyNumFz0+spLnEr5ECr6QoCHjJRg+JIULKsPiG/lx4sozwsAO0hY6Y6XSuDMRamIz7yO0Wrig/aufrUnBvuYrYwvtiqZbRIohV/keALpPkgUqMhBd28d4Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943812; c=relaxed/simple;
	bh=aPpEBi0BEh4DCMfH9bo6/TLUAnkG1u4WRoV3fbCRvPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQAkgNUiF0tJ+cQuRng12rVKlxjchduUgYObHu2RS7QcxHlCqZzbiqafUsKWu+nBTIeC9cfQtoq9BOmQnlLtRbJ3HFk45t+/cYUzJ8GV2Eo0gOO8EDZt1/6Xx3cHVtz9QlPxCnjXLhnxPXixY/3eQdyGvjRcSnpGKDbowzPhmE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZfEjQLaj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q/GHw8oV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCaXcc021644;
	Thu, 26 Jun 2025 13:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GDSd5lCm3W0RU4HC+CsfMPHsMMRB1UaKp9Gu0YMwrto=; b=
	ZfEjQLajwWaxTuU4ySEggqOSUJ9eh9BRhAaeNnSQ/6U7ahqnVhA3UyXn/cGy4OIr
	PgvuGxO0Dp2lnyfRZBm/hXwE9ZxZ/f9qLPw+zpuqimt/1PBfpuYaR5N9jo3ky4p+
	d35oQNoZMKeMgXCqvbZZMJl9y1RlF9YVP/Bw+oGcQXy7joRhu3Skc8y7pe+6FSqt
	lNkDkLv9AWvZpADK0k+sqR/5DTeZg6vSeRFDlLHtGcPPkd9OtUcT2pztNQqrVEyD
	sS75Ao3h8qMCKiNlWyFo5k95aZ9FGuf7yGTmB5kgxeXw8uZ10bApO6ITKDSkpjm+
	x9OYmkNkbxvrXXxHO8MPSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5rppj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 13:15:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55QBsGBH034582;
	Thu, 26 Jun 2025 13:15:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehktfuny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 13:15:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhH7xG57nuJ7CZV/QyFJEebihbsQj0ciDKrcMwzbX2nIEK6f3Zl3qPP0VX6mp2FHPXhQW4ycHk+ynML640tV6fcbM/cIwh/zR+sO/lid9/DvgU/I3thPdoF+k+dr07wlJco59UMfQKgmV5vu1B5peBxdVZMkwfBVXukqkORGQ4gYBYTGMU3LVJkIUS/dJpLw3ZlindTvJqWq/KIz5njXvkwL88uUfJDLQ3JmsDmmrfJeskAvHf72llV9A44GB6asvv36T+JNamx9+I3INNShaZLv4swf7ASc/7JGHmSVlu0nkO+BqoxX3Dtn2IjiwFvonDm1p2TcG7S8tn9tqVUzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDSd5lCm3W0RU4HC+CsfMPHsMMRB1UaKp9Gu0YMwrto=;
 b=AhT65v6+edcWitPzu+Kp73In/dCzAbACa+eCm/x/m5Neyr0GhodmBY1FORE8+NzQdLgB3GmEUUa9GhiH7MwubuIwFxIJdZ40HA1rQPyX9SKNVd5ZD/+O2elJAGwIHmppwuSnijh6MaWpx6BH9ELTRllA9lnfvXFLQtX6z7sjVLz/LI+4T/wLAb+K/4grSxdY5FqxwXnRT6P5DYJVwDB4xhJoX0AaEHANQlZEZwEr64aLxOh0y7VCRsljTKa1r6JCPuSkl9pXY/VNPx0IAGZUr/nMfYbm8laOy12UaTe12BfHuOKNxJghyF4Yb5hEmXO4/fdzQ5m8Sk5TvQvsXjfyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDSd5lCm3W0RU4HC+CsfMPHsMMRB1UaKp9Gu0YMwrto=;
 b=Q/GHw8oV8dZgq2ye7tIVr7IIwf5/WSds7psSsZg2HGfKFhPdv62mD1Bu9V0E+/BXEEjwfQBt1FsYMLIE2BdFwaZ8pgDQZ3TlsGv/kgZyXCs9bCxi+Orb0byoYYX+YYWyeqqudp0WDSf6mf323E7WeHSNginyXiHsmm9Mh19gaMI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 13:15:48 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 13:15:48 +0000
Message-ID: <0d315950-89d3-4fd1-acfa-d38c9190b36b@oracle.com>
Date: Thu, 26 Jun 2025 15:15:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 00/16] x86: Enable Linear Address Space Separation
 support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <9b1c5e43-ff48-4af8-9ec8-1c1dc2b902ae@oracle.com>
 <1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com>
 <ky4an2a4ks55phzuzdvb5py4psvgintt4u2rmthhx44zsx3gqn@uxw3sebzpbch>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <ky4an2a4ks55phzuzdvb5py4psvgintt4u2rmthhx44zsx3gqn@uxw3sebzpbch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::10) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 922cc66c-2cd0-45f1-c0be-08ddb4b390e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU94SDJpQm9Eb3RkOXVPQWY5RTlqYmMvL1ZXVjdRZEhKVGs1Q1BYNCszWTFD?=
 =?utf-8?B?SHpZVlJ2Z3g4UkdnekFEaDU5WDMzYjA2anFSc3VhUml1V09SVmxDSVJ0VUFQ?=
 =?utf-8?B?eVVRcFFjU0FJeDBOamk2Z3o2YmN3WXQ2ZytKdEJGcGk3YXNrUDFkY1ZMbkhj?=
 =?utf-8?B?a0JRUE11VWZMamhsdzl4dThoR1gzamxqa01leGY1OWJMRjlQNS9DTHpRZk5Y?=
 =?utf-8?B?R1FNMW5zbWlkdDVTQTRiUjYwYTBTbVpXbk9sM0h5WTNsc2RIMHpXdm9Fc3Fx?=
 =?utf-8?B?V0hWRjg1cGNWVEVUMjlVVmwvckJyUlI3bUZTWUE1S25FZG0wek93djNhNHg4?=
 =?utf-8?B?R3ZrZ0hwTWhCOW11NEs3YVlScllmM0YyRlpHNmhTcVZoakVUZWFnQW5HOW9l?=
 =?utf-8?B?QkhUcE9VVzlmYkRpenhYMWlja2VXQmE2VG43WENIWGFXanljWmRITTZOTkNN?=
 =?utf-8?B?SUR6K0hobGhSZ0VVbWo3ck81YzRiME1sM2hOeDlOcWxpeXVtQzJzbC9VU1F0?=
 =?utf-8?B?U3FXTmtSTlRPcFkwSGZqak0zTjlEN1ROQ3d2WkIwRlZQbTRJM0Z1OXN6b3F1?=
 =?utf-8?B?bEJ0SDU3eG96azk0RE9iS0hXN0dGODZlRElzUk02UmZ3dm5wemFiWXRMQ1VF?=
 =?utf-8?B?ekRxZ3J3UzJKa1VCa0RwUTlIZy9OeXdBL3MvYVdXVHE5WTJwa1dvTnZVRmxo?=
 =?utf-8?B?eUZ5dldqRWtvbHNlWXNGdGkrdHh3T3lSaTFpbUpBeldvZm8zTUx6SzZLMXMv?=
 =?utf-8?B?YW9pQXh2eTBqc3dKMlZDQ3RLVENPTFlqQUZ6ZzhIekhRU2s5RFl2NUpleGZQ?=
 =?utf-8?B?MlBJcnF3cGtnQjJ2NUdDci9IRGxwc1BFZ2c1SjVaZGVxa3RQVU9sU01Lcy9q?=
 =?utf-8?B?QmJUVi9tYjQwV25qWDg1YmpOVUE4UERWeTFqZzVZVjhOM1RPN3FpdmFxM1d6?=
 =?utf-8?B?QTRleUhRSG15QllOMEVjWkh1dnEvQzgxNDVSRmhRSEdzdDhXcmpENVphWUFX?=
 =?utf-8?B?Y3BvdGhXemY2U2luTHZ3Z1V5c05GaW4velVHWTY3amRSRlRXcit1cVpGeEVM?=
 =?utf-8?B?dVFLTk1rTk4vQ3AyQUZWSnJWN0lCRFVURVJDZHZWVHZ3djdYRkhQNHJHb3Mr?=
 =?utf-8?B?Wit6QjI4NHFjMHkwZ2Z5Zm5lbWcrY21DZHYvRWRiczBIM2FJUFlnTjQ5RDFI?=
 =?utf-8?B?VWIzRk80UVlIVkpsSmd4U3cwQ21yVWNvM29vSHIyWlJNM28rdEFOL2tJdmlI?=
 =?utf-8?B?S3VoTktqQlpxOHkzOXNqTnFEaEltYTdZV1Rxbit6RC83aHBlb0V4N05LbW9x?=
 =?utf-8?B?bVBxOXlXWjNIWVRKc3VjbmJXOXUvcnY3OWkyNXhpSWpIUUQ3dy9IRXdNc3JF?=
 =?utf-8?B?ZFIvc3ZjeWxHbS8xTkQ1U01OTFRzZjZTMmROeHpacmh5cjZZZXhmdmM5bVln?=
 =?utf-8?B?eWZXMUhnUy9MUGxqNEU2dHBCMm1wWjQ5RzlpbDdnZXlPRThVTTJTYkwrcEVQ?=
 =?utf-8?B?a2RhM0RVcTRtbjg4NWJaeE9IWTlTOFlUQitXYTA0R2VmT3Npa09qY21jQkda?=
 =?utf-8?B?TjVTemg3QTVwYlVCenpnQUZDRDJTaWFOTTNZMFpoTWRJY1o0VXgvcnhYQjUy?=
 =?utf-8?B?Y29FWnF1OVZnR0xBYitiaWcvNGIvTzZnSGwzWTlqbWN1QXVMWnlCNGNFOC94?=
 =?utf-8?B?RktTMUhqOHgzcmJ3Y2loSFZtSS9TOHYzcXpUMmFSUE0vOGw4dlRvYlRteE9p?=
 =?utf-8?B?YUhMRjU4SDdIako1MG5tVTd0bmFObGhrQmVNUys2Tk5JMlBoYURQSEJ5NCt2?=
 =?utf-8?B?dTNya2p4VE95N000cWlwRVVtcTZyVHRTQkpudVdBaVYraC9jd2NzS1ZaMVh6?=
 =?utf-8?B?KzZEL0pEQ3d5UjF4d1pvVnVBVmRKcFpZSDArZ3dRSDlHaFpZdzc0QVpkVXFx?=
 =?utf-8?Q?BBuiO9lK1H4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WldDM0t4QzUzalpvOG11N2QzU0ZKaklPWlhZUjZFRldqeDQ1TCs3c1ZGZE84?=
 =?utf-8?B?a0FaYXhFS0xlcEpSVGNmelhaNHQ4cFlGbFVveFBwL3JSRHJCUEJpL21GWXcy?=
 =?utf-8?B?RmF6eE1QVGtJZFFmRTB6MFlqTmJvUldxTE9oU0xUTzB6OUpzbmYwR1crTS8z?=
 =?utf-8?B?TDFoWU5QSGhDUUZJdU9YcWUvSTFLRzY5UExmN0M4YXJoa01EYzdicDBrUllo?=
 =?utf-8?B?TFZubVgramxmSEtVd3R0K1Z0LzgwRzJCcmlTc1ROSTBpcS92eDM4SjZQdW4r?=
 =?utf-8?B?RUdGd001STloQTdJbFZJNnZXc09uSzA3K0JQbWVFMHJ1ZWVrZk5RQVhWUGd1?=
 =?utf-8?B?amhyTmsweXk5MzRveGd2S1JKaHFpeFdBUVJFV2owQjBnY1pqWHJXUm1DR21p?=
 =?utf-8?B?TDFQQmVldVB4RTcwNkxlSVd5WWFpbjEyT1VacUxJaDVESVViVVNJeEdGaWZB?=
 =?utf-8?B?d0lyMjhoZ0dycEdRQXdReGJRWWxkSmhzdVBFVEdUZVBDOW8rQXJQczY0T2dD?=
 =?utf-8?B?Ujl3cVpDZzd2bVhjSk5iR3NGZUxreFdCYTlSa2pUVytzVzlibU5ScUYxTktU?=
 =?utf-8?B?dk5YdTVyS1piZVBkeVUyTXJ6VlNhMHN4V3B4c1ZzUERiTjNMOGRTODJLcmkr?=
 =?utf-8?B?Wk0rblh1N0MwT2FaUXlId1N1VFBqS2tuRDRNVEp5cDhpS3lyVnlTSTNwVGlx?=
 =?utf-8?B?MFpObGJBajQ1Y1JObVdCTWFaZ1JBMU5UL3pkN3E5eVRMUmIyKzhYSkRrM0tH?=
 =?utf-8?B?bFRWdlZ4TEJ3VWJ1a20xUU5TeWVDTWlraUlBMXpCYlZzRFVXUFlKVk9MSHgv?=
 =?utf-8?B?NXRkKzJxT2RBb0tISGEwc0lXRk1jWUxqUUdsa0p5allBQ1VONnlJcUk1WXZF?=
 =?utf-8?B?ZVk0M0dGTEdiV0UwNW9XOGxLeFV6UkhqSGVDRXNuOGVwQlJSR1A0cWZPT05L?=
 =?utf-8?B?SHNPMU9zYXNLTXo1bWg4RURPSnE1SlV2L21rdXo5T3orcDljRTZpdFhqQVZD?=
 =?utf-8?B?aG5mdVBSa3pKK0ZJWmcxWERaVGNYR0loYW1UZGRGRHIvYzYvOGJJOFFJL3Zx?=
 =?utf-8?B?VnFiSkNrTHRaMkV2SzkyWDFyOTJQcGYzekhGWXdLS0RtWFZ1SHQ3VSt2ZXMw?=
 =?utf-8?B?dDNQUlIrTHJ2MWJVYmVzU2tUN3MzYlA3RVpxNGtDKzE2U05RQU1LbVNIellS?=
 =?utf-8?B?a1dDeTJRSVVQVXRHd3NTazVTQWhkVGNsY25QcjRsRy9tL01KeHY5RTB3MlQ4?=
 =?utf-8?B?aFdaUCtPOC9DYTJSVjdma044VmpPS3VRbWQyWXNheVZnZGgvb0p6TVUxdTZj?=
 =?utf-8?B?Njg5TGdyYUxWSk54aUdEc0NxVWpZVlJDYVIrVFdPYlArZUYrOTFZK1VzTC9n?=
 =?utf-8?B?RlcxcE4yR1Yva29pRERwL1lWdVdpSnlwdlJqcTF2M1diZlo0ZjhtKzBXZ3V3?=
 =?utf-8?B?amNQaHord0pNLzFkNHBnYnZ5WVF1T1VrNWVTWmtEb2RxNmRjOXM0VGswNW4z?=
 =?utf-8?B?TW5EeGVWcDJtcE5lRm4zb3dibDRxSjIxcGJmdEY4ZEhyM2VMdnczU0FnTjI4?=
 =?utf-8?B?SnVHWXN4S1ZQYVNTb0hJaWZIdUdEL29QVGhHQm5uU2xNZjJzdXltUi81Nlcv?=
 =?utf-8?B?bmFrTEowVHYvL0RCcDYxYzZMV3Rjc211Vk11QURlTW1wWVRMcGlweDgxekFD?=
 =?utf-8?B?bGtiQWJ3ZnVQT0FPTFpMMWlxem9Bcm1Nb05KOUY3OE56TG90TjgxSGhwR2Jw?=
 =?utf-8?B?UWpYcEhuWHV0ZWc4MkRLQmRGTkgwNmtlMC80NUZQcTYzMmoxa25NWDVZUFBs?=
 =?utf-8?B?OXZuWXB3SE9QTVM0OUwyeFZSM2F5VHFVZTI0bnVYeGRrZU1xV3FzT3B5MHRG?=
 =?utf-8?B?K0o3anlJZVQxZE9xMU1menVQK2pXS2twMkwvMXlLSGxUQjBtWUpORXdsNEFK?=
 =?utf-8?B?bWk4Nld0cFp5dThXSTdTMmd0WUZwQjVjZEJ3WXVkZC80SS9sOFludGc4TWpH?=
 =?utf-8?B?WVUyV0VtSUhXK2hkL0Y4RUtmOEZaT0YvSUdrcGVOUVFoaTBDejlsWmtwU1hP?=
 =?utf-8?B?clkyQ0l3TjFHalRMbUQ0U2tIcnRsblRtMDRQcnE4ZWRHeTZGRnRIaVJSeGJQ?=
 =?utf-8?Q?iO7esdxlNERIDyDXmp1t4kugt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YqIUfha75ThB+tIQOU4HDs4iB4S77CX5NVI/qpgiYtJLENJmE0ZLbIhrpIN8bmICNtrBGrmv2p8QsIULLnIj933sroSOifqng5XQJdKCkPGNtuTP1+h61YYjyVEQxO8/eleCfsrGXH1s6OwLLcq3bWa1dI9nyfGqK6sP+IV1YvriYFOdGaCU0KQ5ryXbdQEsHs93fa1hC3eZzam1qFXhkaY04AlPTMKrEic4MI6x5zWH/pNwRCetrk9Dv3TbUnA853c4qMpbtB9cI2WSTvnG/9tnCWOqkooEctIqip8LxLuIigR2Ibx1ChpoH/kZxtBqxHOpfyLbTYN+HZ8C5xrR8UCEtnvHBNGPYW4fVJeps2bmca/nlJsbRdhu07H/9SW+lX55EF021K/iZcdgdrZ+WpeiZKMuvA2OlaltZ/KuBkrxeTFvvCSgS1rtCaErHvGFUKVgpz31lGG8jUxMgWJQzqzKz+wysw8k84JkSCmR/cizUe9LC/9axxZLnG28qx6dGHpGqqzhgk9oO9Q4+XoSBFaPiPdWx+Or4K7GFnN9qsa21/ESGd9XH0EDbusy+bjG1Zy5ywnergKOzqrcBTAlcr2Xd3d1Py4VGvtVTGfihk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922cc66c-2cd0-45f1-c0be-08ddb4b390e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:15:48.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84JgvSMvDwFS6WqMReoqbhxnNj7h3NdYvJVG2JCEhJihzmK4LMXQFkoS2oG3L6cUHXsbyJdKv/yhDZScrpsL5XsVEKaBk5BG7ynKdX19N/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506260111
X-Proofpoint-GUID: VZH8Gk1M76emTxaAD3_nkHiRiX-5k58X
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685d4808 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=n0oBUCBUDrvsEmtUyucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDExMSBTYWx0ZWRfX+9x9zraaJrQD xkX4PiqTDfWJ8HSJRaGsy0gdHQ5rpxBGHCDxe7Q9g1EzLVFOHBcKPtI6VbONNG38W2SDgpEw5N0 MtLplOX/xyK//CeVslTSFUHFaZRA+GrEYxMEa+O2lNK/shs+lqLqvmPAE1sHBizjzVZM4y9b4Zn
 7NL6ZtX95LALNOVp7GXkURlWZVl3K0bkmpVTFa2vUhAdDED4RgPmFF+ajo64gguXj8B2luAOvxR XhNlVtgh5VBNp44wxR1KSc9kc/prfKY8OkShlRpxZD0MgqygtEpJXlEnQa/0X3OJGwL4LE29wTe 4ciJ9HYfbnkWsLZ/7gPtRQrnaE9/ZJn59/qj77X0WWMSI3O96bMUmyia4qm1pgi8wVSqWbarAp/
 DBYpWmeApMa42ndknITvjZOxSSSuA7HG1A8RQdbMzH0k/0rhXxCll5pPXXvucbYHSQSifgBA
X-Proofpoint-ORIG-GUID: VZH8Gk1M76emTxaAD3_nkHiRiX-5k58X


On 26/06/2025 14:47, Kirill A. Shutemov wrote:
> On Thu, Jun 26, 2025 at 11:35:21AM +0200, Vegard Nossum wrote:
>> On 26/06/2025 11:22, Vegard Nossum wrote:
>>> On 25/06/2025 14:50, Kirill A. Shutemov wrote:
>>>> Linear Address Space Separation (LASS) is a security feature that
>>>> intends to
>>>> prevent malicious virtual address space accesses across user/kernel mode.
>>>
>>> I applied these patches on top of tip/master and when I try to boot it
>>> fails with errno 12 (ENOMEM - Cannot allocate memory):
>>>
>>> [    1.517526] Kernel panic - not syncing: Requested init /bin/bash
>>> failed (error -12).
> 
> For some reason, I failed to reproduce it. What is your toolchain?

$ gcc --version
gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2.1.0.1)

I tried to diff vmlinux with and without the clobber change and I see a
bunch of changed functions, the first one I looked at is calling
put_user() -- I guess anything could be affected, really.

>> @@ -28,7 +28,7 @@ static __always_inline void *__inline_memcpy(void *to,
>> const void *from, size_t
>>                       "2:\n\t"
>>                       _ASM_EXTABLE_UA(1b, 2b)
>>                       :"+c" (len), "+D" (to), "+S" (from),
>> ASM_CALL_CONSTRAINT
>> -                    : : "memory", _ASM_AX);
>> +                    : : "memory", _ASM_AX, _ASM_DX);
>>
>>          return ret + len;
>>   }
> 
> This part is not needed. rep_movs_alternative() doesn't touch RDX.

True, I didn't look closely enough...

> I will fold the patch below.

Thanks,


Vegard

