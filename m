Return-Path: <linux-efi+bounces-1260-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD169110EE
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 20:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415BCB2BAAB
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2351BA874;
	Thu, 20 Jun 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bpf9YCMz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C801BF325;
	Thu, 20 Jun 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906904; cv=fail; b=bSbsijUpLPzUQhUjeW7MUEnvR95e1moZ+QqeYqNGSou4x+nMiERX1wVyphBi/+qV6gWUsbzxz1GCv5SY0Nr6k7dPU/1zjCZrPt6yBQSPIjg3+K+IFtOuacDdfs3WB7fxtMzfgg6O73CALRexitB/2Edo11vRmwUQHYTojdogCa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906904; c=relaxed/simple;
	bh=sHzhBupJs6wY1TJx/ipbLrrcKlxH/gXfk7zFkACoj+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSHIkisvN8c3RhzkOI4KERysB/qgsIJfIo3W5NUbMXOsAWRv/kgAN7XudCMkW+s4TzHKh2cdQeeuKOtZNcDnGU1g9ErMvNZ6vZ42/O5h+N4aUO+ywy5okd60OIgDTw6Hihrq44EzdXsdFO3yPJZwH04yRNm2eKdKm7cHMEn5lMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bpf9YCMz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718906902; x=1750442902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sHzhBupJs6wY1TJx/ipbLrrcKlxH/gXfk7zFkACoj+4=;
  b=Bpf9YCMz7fiXjjmeNrwkcgGv/uhbzvDTgHj+dlI/zRh3aKbsJy1fEL92
   6y1C5jcnxq9ZJ4ynEl7sg9lvHSmiiOEdMhftA1GuvFeEnSmi0RFSlbAj/
   jR1AEG+UAkLDSTv1gio5EZgNzG6T5XKUEJJG5bj8h1+EzSzY9TM1IIF0m
   owQSpsWreZ7SM344LvwnQPE81Y3gQSjBMSUWr7EhoiCbvs0xsH6DGoYiR
   3FnZxDKVc2Jmls1FI3UEsfN4cTTWADzxY8zQXyTcSW7jGQ7pguVNa/ZRt
   Wn72twv3tLrx0umZKf7yK2O3nS4IafEq3ig8nVOCfy/93ONXdtoob5sJf
   w==;
X-CSE-ConnectionGUID: gTvhmhdoQ92ZIC1e/MnsTQ==
X-CSE-MsgGUID: nmXLXbyeRCCksyj69u1gjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16141825"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="16141825"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 11:08:18 -0700
X-CSE-ConnectionGUID: igit3GDXTGmT4yj/PrSGmQ==
X-CSE-MsgGUID: yMhQ8UNLQDmsNVONc7eDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42282196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 11:08:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:08:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:08:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 11:08:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 11:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krLqxMSl9DbW9a1F553NBR3xQ2NNeVubYk74C9W9oRP9X8SvBa2U6qymNk7pibs5k30q5RpMcN29A5hejkYOeQsdhxVRYCGLQatfWnz4jQ8s/fIES2wbDTzWjcO9TJNNLH4dRk28qcw/GH6I4TJazIorbAWuCbBVJJckxz6/JRWNKARtVX/DomMbiOn/RQSkHuZmXcr21trkWHimhEZ8gD0XphBsmkh5yVlQmlTJKa4RVelJ4Lj4oJ7xfuCLB+jT4rFjJ9KSWc/far7TfBGBWHfKNeeWi/D4wWpImMsP82gPtUQDjtMzbY16SBD3qH4NxqZSxghZ0eNdvBbrtIW1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBwA5CeBW0qmlppEYkeddFHC4Lx+PFhye1mKdbim0Sc=;
 b=JLjtrekGhJvx1hjIFsQZ9XilLTOPwp314J4XWxqt9wGA8EBBLKzRAYVcqC1JtgLU/27rWE3sm1YWTVvFESg3AWHwx6TNicP/rkZRTLy0iqE0ZDT0IRmjGXTNuQXeAYyEkCxcCcSDemw4bFPP9o2/IFkh+spHclz0DHE3CMod8tJPMS2gcsu++3h1oDoFNZIl/VLKv31rvFdhIzsvRXWXjukxzXYYZovXdGvZebNz3Zo2f2PbrUG2rcVdWspHc7x5qlv/gBrWIbmUAdLu64Gj4c1QjNhmLnmuZmGkOEAbY7eYa2WxrwumNWbhhedRh7P1GibNztUTfx1RWMukUp0ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 18:08:09 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 18:08:09 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] efi/cper: Add a new helper function to print
 bitmasks
Thread-Topic: [PATCH v4 2/3] efi/cper: Add a new helper function to print
 bitmasks
Thread-Index: AQHawzv/O6JTwuaFzUC0rDJweD8b47HQ8tsg
Date: Thu, 20 Jun 2024 18:08:09 +0000
Message-ID: <SJ1PR11MB6083DD6F7420EFB8590A1767FCC82@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1718906288.git.mchehab+huawei@kernel.org>
 <fcc8a699c9497b788ac99aa0d57dedd629ac4945.1718906288.git.mchehab+huawei@kernel.org>
In-Reply-To: <fcc8a699c9497b788ac99aa0d57dedd629ac4945.1718906288.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB5936:EE_
x-ms-office365-filtering-correlation-id: 65b0cedc-ccbc-4854-b4df-08dc9153f12f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?5GqYKSuau/x0yubNvZg5/svHtam9wMjk/5f+Wv4B8QxvlSr4PZpgatRy8A7b?=
 =?us-ascii?Q?y3K6LDS6H6qfgr6comLRpyszzS10gv6FFcJQaZnypYb8cPv/SUFVh51OBGQF?=
 =?us-ascii?Q?EE6l7sOCBdIL5ZoCcE0V5umcXN91tmm04R4ytGNGd/tZUsoQd21cFlqYltMN?=
 =?us-ascii?Q?FU1zrgRd1OQmjbigMuiCoQvbH4336PeL/hMQHRJkyOcF1XBeAV1fD+0BzWcI?=
 =?us-ascii?Q?oiJEVtFRBOwqZfPlGhJAW8uLZgRPqWd6irhM873gNf7wkCFericD9+6nRr7u?=
 =?us-ascii?Q?FJT1C4UxoU5ijnK8xWEGahnfOMewKKg1m0oPWbgt7WZmDvn9CtZzxN5vmqfs?=
 =?us-ascii?Q?6kdGX4Iax4m/nZuXf9+CICQ7oJdFJbL09O1GNihubeYh88P0mjyPynqRXU61?=
 =?us-ascii?Q?wRbwUsHqRJpHtcCSeDjo1I5p0MG2LGfjgg9lv3HvXh5upb7w/mQe+0/edGPW?=
 =?us-ascii?Q?tHjygVQoBIcRWiCtbr5hGHVQzw0L9Ut9V2LHE+/mX9SPfEtiH0rplXOuMTx2?=
 =?us-ascii?Q?GRJlRiZEQ6pLxrDs/mz62IsC+PqscPriwn/vJdpkDGNCrf3MZ7IRYwBSh5IG?=
 =?us-ascii?Q?a78bbXSw/py3S2NaGZA8pmx26lYpdqaKQQlMYirBVbR0Jsa369Udt7UQPZ4q?=
 =?us-ascii?Q?LK+vCV09jTK+t/EqNm0mL/NlKjAOLeJb/NEVyszjyFGaDc0nAeDASfs+ycNi?=
 =?us-ascii?Q?PibQoBS0QWpk5+7eDtgKKN73xkOMLKqYgRDsd3Br1D0sgGL3J19IWmDC4jk6?=
 =?us-ascii?Q?vbwVUYjiK9efxgpaC5X+Sdrkc/qn99hYcRVT6Lu6qhIX5rzg+lByWmBNQrRQ?=
 =?us-ascii?Q?fUorMCNjtJbfTQ90R4NH0sCYhMoRFNQ923CNiOwYz9nBSLdpxyqU4ag3CxrP?=
 =?us-ascii?Q?OAt9fTI0fYcNUU/d5uXdT06ECB7JbvHmopT0Ij1nKyzdwM+TjbT9d+EOACfx?=
 =?us-ascii?Q?bSdNMWuUxT0E5K69hnSTQsG2CSdxEQIj/PO1HepJi1r9Etu7UUb2aqbndetf?=
 =?us-ascii?Q?xtiADHdfAWnMja+COY8DV5BtmiTajslo6fUpRaj2tmevT2yRA1dyVpUafmyS?=
 =?us-ascii?Q?1cBkPu5SC3erG2gvzAA1JSlkiM+Ej+SiY2F8qvu2ERfSMNwzs6g7+M7rkrhA?=
 =?us-ascii?Q?8KanDW3boVbuQufMsuNTlVs6UykAUYilPSmk8oiy1lqptleD9svrx/1PvxvW?=
 =?us-ascii?Q?Kd5QJzVBDgL0oaxWp1Ns9/B9/UqUZSClQCEzVNF78DjdTYLzMfDbIDpKVPcU?=
 =?us-ascii?Q?Dmd7T6/LO41uni0JEg2FOknY4dc19dmTi9kWGd9va1pIBRFeFbQF2LciPZxa?=
 =?us-ascii?Q?x+dJXCrZZ4ZrD1h8yIOizO4NHDNq3wtld6UPHYnZS+1kOuuMQTIROLnukSXQ?=
 =?us-ascii?Q?xj3Bc5U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmo73tqrAktDMgPfYMvTFILhYPleJiuCZTkz9lmwb00ccpMHzMAxS3oVRHV6?=
 =?us-ascii?Q?jRRVouksmFVyprE6oHDaOcDzBkxKTq9lfGQ3mW/nJnqbQWOi+tzGgQZS4q8s?=
 =?us-ascii?Q?hUUsZVmeI/FBThwQlrHLVgwdgKnhs33fBL0OUS0OS3M+di/HYPKNpOY6DyHz?=
 =?us-ascii?Q?xCxwUJAubfTPHdKuFMFZb1dsH1Q/VRPGtF4Q/wbNhnXTPBkxXqeSz7FQymLI?=
 =?us-ascii?Q?WTjw1bKHh+VVM05pxV2fX9T7Qz8zh2hF7Q7+eFVroOa0ZDZjsoHqMHNj91JR?=
 =?us-ascii?Q?qD/PhgqWwys6EmlZ+joNoz+PieEzKTmWINuelHh1D4IpHD2gZ0vLJIxJdlOh?=
 =?us-ascii?Q?1EcMLCzRIFqigVccsYK/E4vMvy6+lUDKz7lbzQSnbkuoElqKWcfINwJVmY7I?=
 =?us-ascii?Q?0IOxynfdS/xpwBq5Hu2S910mnOxPqa/l1DUgaI3K7tB/bmnmk0YgXwJ7A3MC?=
 =?us-ascii?Q?4FTKCb0LzJLZKrf7zeXROc+p1B85Yal1UicKEFrlm8Lv0ICJGM2eH53HFZgD?=
 =?us-ascii?Q?L/UVQ6+A81Xl61l8WCOu5JjrGCrUJgvmU15QJ+jSXKaA6p1J1AzEOROuDsPi?=
 =?us-ascii?Q?2I2l1N30KCwF2v6Fi7MNxS33AdnhxDO2y6Y5i8UEnsWSQn8lj2NPCW23irAa?=
 =?us-ascii?Q?DXpq/cw6/cutTYpqFwREOqkDXwCTqzovamrifuTYtKK8EYLNFyN9coLQRQ2f?=
 =?us-ascii?Q?YuDzWFGtYa1M4+RVhnJqiDw+oEVbouttbQz7ZfXlwnej4eZOQcwZ/KfqcIZ5?=
 =?us-ascii?Q?JKU1ytbUJLI0yTv2lf4T02GMGjefOPBRT6LWj3ke9dv84lPQC2OajTF8x8IL?=
 =?us-ascii?Q?0RgL3x421kvRBQT0pe24uU+YVUmd18p+I2DeNiwFQQn9GrSbehG6Ehl1JS/J?=
 =?us-ascii?Q?5zB10kyWyEi9xLJ9m20LDjrYPpoJQ7hORd3wlYTOwrQzP6QpCyNURS8N0TIZ?=
 =?us-ascii?Q?4bMnq2ZpifpF/YGdcCNXMILw8QAvwHtpW4s7Sc0sloFF05YV2xqM742p3OuG?=
 =?us-ascii?Q?5OAQhal27fouJ9ny3t/pUh/WptHnF8HekrAen4mtPSmY34TiP/wBCCoHxBBZ?=
 =?us-ascii?Q?JkJOLOpvPdcPC7O/vjkPuun+I8nP5nSFsw9Sxba3Z316jNlKXdS+tI+vtqiZ?=
 =?us-ascii?Q?IpUqZo0t/rmxwn/P2dctoUvInY6ytu4MFx39gSUzWaM/apOiSleerrSj8us0?=
 =?us-ascii?Q?h/MShcHevnXpEd+N04samPP0AGxeV+pDOnvQSgja4Hw/cpZEXzZjj/xsJ4Y5?=
 =?us-ascii?Q?9Zs7Z+NkjhXBEwNBH/oKZS1VlZD9o+2Msfh6RAkJ6x9TNeLiOerzinQJ/JNj?=
 =?us-ascii?Q?+3QKOC2aHL+unTEf1N0YkK+M9e32pn72yjp63psIhbokWslZYt8+H8ziV5H+?=
 =?us-ascii?Q?fsK/dt8zSRYEwE2usgKybft+wr/yEjUQM7hIb0wFdJD/63R9jOOTd+ckd16/?=
 =?us-ascii?Q?N2UAaNZV3Y1XNL0tl5ZB1jfUMO/AjHs0jeJru8hAIckaEu6PebesPDkjRkB9?=
 =?us-ascii?Q?LlM0o9LwyiMhBNKNU7FFFXt+eQaYRR25Jv6bAyloSCgmVmGwCHdVUMcTtdCo?=
 =?us-ascii?Q?CPuo2GaR0vJbaUKKwln8qSnqpRwcjEETBA/2fqOq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b0cedc-ccbc-4854-b4df-08dc9153f12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 18:08:09.3976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwygziGj8hiawSVQLtdRibPcwvPfh6WfjbK766ze32gILKMs2v214/7vEWbo3UU3LwuXfjJvo42vDhKWuh5Fyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com

+
+		size =3D strscpy(str, strs[i], len);

Check for error return from strscpy()

+		len -=3D size;
+		str +=3D size;


