Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E967F264
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jan 2023 00:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjA0XuM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Jan 2023 18:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjA0XuL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Jan 2023 18:50:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2459E50;
        Fri, 27 Jan 2023 15:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pjks6Fmp1g2dsFzXh8qyPUim+4Zs2uA9uprm2Art66rd9SSs3VKdFrfk+5R7DZSyrCjlE7SL04Pb13V9bXxiKUagEQDWenpM7It0pI3HD2Z/HOIj38sf5sJpE1UHNypm3NZyFneHtIOsbBa4o0WgTJBLw3wh+hf+0TDcUqWKrdvF7pTbPhBZXh0DNezs+cyRqPAMOs6EtgV3aNQuWqrdwNWXGZ2ikMlwy5cb0Coo3e6zRHGWIDZU6Gksf5zUE2G/uOZN8hh/kMzlXG6df85Ws2ERxa4cl7HULL9FY+Ei7SvN0fXDtOav6kvk9LR5yNZsUdb0wLtrslTnKuXahxM82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfxLkZ0M8kzoQwKg0OP4oTrCOXDgK9Z3S7OijSWFCdo=;
 b=QK97MW3yYOQDCj1s1XiUkAQ+7Q99m1EZ8FXtrTNmUg0Lnz7GBBXY1cijvB2prrjBynxIRIWEqThmLw9iRON4WQKV3zGAvDWnBMn/dUqk87y7mDhpdKaVSLfeMBifp8m8An51kMEGUU12bVv+aXZbj2xk8EDv+41dKm39wBIUzSk4e2mejMiZV+Iv+G0bUPgeH0f3MNrNC8AqTs6b8D+ivhbrdOeXvDbuFaAhtkDCJ0xcK+fSn2lb3T66vfIGd8nqKdWx7K0xyKi8zrSJz1JoIXOekd2LHNL/IL0iC+++9RGzIoyK9w62DGVDh7ZW2hmdAiJC6v6hgd6E2Jbjg49FEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfxLkZ0M8kzoQwKg0OP4oTrCOXDgK9Z3S7OijSWFCdo=;
 b=bSbQrfWcs1DHZecZn8fC2gfN+zd6cOBQOzPro5vkzfVdyjh0dFt73aO0IVMUgoyeUAvUCDbcbdR+BBgzdk8ZebZ/Sugb1g7xBwHkAObk5AZApUE+FV1D9Udfgl6VqErwgOhzFTxa0G2Ggctg+hgkmgYxiSJrRUZzEFV2tFEdM9Q=
Received: from CH0PR07MB9824.namprd07.prod.outlook.com (2603:10b6:610:184::12)
 by MN2PR07MB6286.namprd07.prod.outlook.com (2603:10b6:208:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 27 Jan
 2023 23:49:56 +0000
Received: from CH0PR07MB9824.namprd07.prod.outlook.com
 ([fe80::5075:36b0:3281:92fe]) by CH0PR07MB9824.namprd07.prod.outlook.com
 ([fe80::5075:36b0:3281:92fe%6]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 23:49:56 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: general protection fault in efivar_lock
Thread-Topic: general protection fault in efivar_lock
Thread-Index: AQHZMqkdiJzoTGJpGkqT9je6cKFXFQ==
Date:   Fri, 27 Jan 2023 23:49:55 +0000
Message-ID: <CH0PR07MB9824F9A2F2D6B9612BCD2318ABCC9@CH0PR07MB9824.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR07MB9824:EE_|MN2PR07MB6286:EE_
x-ms-office365-filtering-correlation-id: 2e1be354-00fb-43e5-b923-08db00c13157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ng7xgt9xUqFQGIhEa63YMLtv3MLDb/SlHqV+G4Yo9zYdQiZy6742rJIrYqbHbppMp9cO0ZnhTgp8Qy+sTEAUlGDs2Xm1ZcE9k+SQJstsqVXQhHHxQsbVt+vI4KHzxc2efk1b+ExMCTlkC6D1IGCdxCKV1AQYIGyqGWTjGNi1muMnHAEH/FFkcIsE++7pkRCFk7+7gBIshmdFIm01seu70PXOFpJrPlJEoHsuJp13np60N+pemPffoRj0T2fo1rhm/bZo3lwSygfVAF2crOB85BkFpoEALqrrq5ka3ZSxN3jXjaCICJZyFtlapaB690Ib+z7B42bHHTkqNucoQHbf8LJ2+JuJ0dqOqiuGXb90Va2IvYHu2m7mIHKnFPawjm4eUfxOmF+tMVtPmDfWRQW40MNaoqbW+6rNlhD9SE/0LfubzUUCqQGSge6YW0Zzybv5IAmaxSMp9YMHlkMse3iy+21500N7xWiVHl8LzLCaJ+gRJ/bCFRvof1gy1UGKb9GZ8Q60b7Gk0rxFGXbcoVdm1wJiYNPumky1otUzMwCGMWF3xR5zusSNNVNk91QPvrzIhInGFR5J/c4rH9GMcpOQp8r7EwrQDB7QdkUHUj3PiRXIbn4NAhWXPIYssNZhoEEndA3+o++lSI1BZpbfHOhEacPon7IYYHqvGH4WBakDvMZMW66LzD5V4ACW+l822oz/mQ2/NUkAR5fB+2xXgSrSY/V19dToH+hWLQQmyphN7gKy5LpVJ9Rzg6EmOYTgudVs6OqWKoUh6DxJ6w3vYjXKJVQB+1ORTuOFbcV9k6aJl+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR07MB9824.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(122000001)(5930299012)(38100700002)(38070700005)(86362001)(9686003)(7696005)(478600001)(66446008)(66476007)(45080400002)(41320700001)(26005)(54906003)(52536014)(5660300002)(66946007)(76116006)(66556008)(64756008)(44832011)(2906002)(316002)(55016003)(41300700001)(83380400001)(33656002)(4326008)(110136005)(91956017)(786003)(8936002)(8676002)(71200400001)(6506007)(966005)(75432002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q7IV8XRNCHdizT+KHcPKO1A9IZ3xPS+W8M1XWsbLCuueI4t5oSfCkyUUuq?=
 =?iso-8859-1?Q?w68/G/KHGxMJMDKA8rfPm4GF394Ghf1DQztolQr3ARbgEkriQlqKAN6a5z?=
 =?iso-8859-1?Q?qQnvjt7dzIFWWQzFWj/te4hB4VG6wDpZyPdA4P1EzRihoNRWA7zCwH+pzm?=
 =?iso-8859-1?Q?dG5bKsqkQb5byL8R1/XM68iIggXKVU6PIctEm2Z/9sTFrZ28V2TUit3h/b?=
 =?iso-8859-1?Q?fyP81Gbt9UomgSUYpcLj3uzglvNXxwn7hPIFqgDz3bd7M8xwZxfcs8qmze?=
 =?iso-8859-1?Q?YW2S4qRMHIQ16eiCXf2jmLjb9dgLhesrIW67bVx+x+meu8x6AAHTdnpVaH?=
 =?iso-8859-1?Q?ix+QCEgn/X+PVI519NLfPzqp1UmqSF4pNs0ulKS5ov1EsiAjiazh7OGzBJ?=
 =?iso-8859-1?Q?9MsLmdF8Bgf1UvjQa6f3d3bI/A4bf4y1h7ARUa8r/LWba8pRm5v/yH1h8V?=
 =?iso-8859-1?Q?MQQOid1bDl7xL5xHgngp+cwN1D5/RxFCMKWlIIsdceGUFxE+YL2bJX32kJ?=
 =?iso-8859-1?Q?FuCL+CbLnGpWrLBHmWQQvZcGR15pwFF5NOXB5o05mWdnLTgK7/+ZAaN4W6?=
 =?iso-8859-1?Q?LwXRp2WNB4ZA7u+2J6zZWdZhMj1aB1D9LZipHRBxh6rxnQk+mWg3PwZ6KG?=
 =?iso-8859-1?Q?nFbMERU73DuUUvxgNaAGnE9gOwiAG5GRju26kOyeXNS1OI/BP6uzL6ULUG?=
 =?iso-8859-1?Q?D0ETYsBwKvaCi5gd9o54zMOx4AXvK1t7cuavblAUYf01GX8oM2m2nwTSp3?=
 =?iso-8859-1?Q?fD5+w7FWbsVH7YgAz2Ra6pkAMFskCise3nzXelLVQYb+JaXy5dOC395aYW?=
 =?iso-8859-1?Q?dXedlI1SX+INBNOrNmFUBpGHXeUhj26PB60rHogB3It9Arx8Itgaq64V9m?=
 =?iso-8859-1?Q?H0zH3M3YCVN0tGdgnDeBYLkGmXXcn2zL6yQ8MgfaLt/kW8N4zEBOlJn6G/?=
 =?iso-8859-1?Q?qAt6+EZLX0/IsKNGqq4+YHLiJsm+RcbMkVTX3R/c/dbBJ0BFb6W483Ne/f?=
 =?iso-8859-1?Q?aVnLddsyD0WVqfphLmgVQhy1UDp/VdX2MfCK1FbIUJ8qz5VeOulKUlTS3i?=
 =?iso-8859-1?Q?GWXzWeJzr+fWMeDunXbUzkrnRNpaTKvIWPdVLYHFbd158CmoxSMUPP+RJa?=
 =?iso-8859-1?Q?h2yEj574JH6+79t+El9kTdvHbDLm6MG7G8XHeEN5eqGmSwSzFU8bjgXkmc?=
 =?iso-8859-1?Q?j83qZtYKPh9WwKQU26MiQa1dvP17zdkTPr1js+48Smm2jESwDXAxJwBR3Q?=
 =?iso-8859-1?Q?6UMoHENTmDikjPyPm0Zm/ezpy9lBmRduCNXrdyAz3TVabo1m9jOfWcdGYN?=
 =?iso-8859-1?Q?A4ULs4pOJMqKiJmb0MoIZ3mr1OzKV0XML3/HzRcMx2aR+IoNwGc/I4kMCp?=
 =?iso-8859-1?Q?fCJo+D4/2wcf1YeuDK+AFHOfLQT003Vbpb2iyjiSIyCIPvc7DF/R9ETIGr?=
 =?iso-8859-1?Q?G46+O86rWGncey0qpoo8mQVBdF3krWbYFpAy7ZCZdj3+yAGH9H+znrV0Jt?=
 =?iso-8859-1?Q?mwpkQtwfttLX7JI5lGdLUTSp3X3NsXgNFaNiCjuAj57FvpIANdp7XQC57Y?=
 =?iso-8859-1?Q?31akKSVH9+YpN0IOqHX467n5g5qSSnPtZh4Jps/tANRwCHmxTKQm1fv2yg?=
 =?iso-8859-1?Q?5gzaEI071gOo46HlPk6XmxkWARHSXgGi7JAxxgcP9FLiFSDKkKfIaUZQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR07MB9824.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1be354-00fb-43e5-b923-08db00c13157
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 23:49:55.9265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COpwgIvuolMdist2uwBWaJryNQpzDfuyK+cuRxJIWmwba0wAJT98lt+qL45m9PjO15lBSfzKD7Rj0FgIQvQjAyIg/Bh46Y21QU/ZA/2nKHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6286
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.2.0-rc5-next-20230125=0A=
Kernel config: https://drive.google.com/file/d/1qDN6q_k12wcgp6dt4jfF4hpk3Ix=
5FaKX/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/11bfgp5hzObE2om0k0bNfeSIEf_SciG=
Y1/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0001: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]=0A=
CPU: 4 PID: 27585 Comm: syz-executor.5 Not tainted 6.2.0-rc5-next-20230125 =
#1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:efivar_lock+0x4e/0xa0=0A=
Code: a8 28 0f fc 45 85 e4 75 3f e8 ee 2c 0f fc 48 8b 1d b7 aa c5 05 48 b8 =
00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3=
9 48 83 7b 08 00 74 19 e8 c0 2c 0f fc 44 89 e0 5b=0A=
RSP: 0018:ffff88802549fca8 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003cb0000=0A=
RDX: 0000000000000001 RSI: ffffffff85792a42 RDI: 0000000000000008=0A=
RBP: ffff88802549fcb8 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: ffffffff82595920 R15: 0000000000000000=0A=
FS:  00007fafd9f83700(0000) GS:ffff88811a800000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f9e23270d78 CR3: 00000000233bb000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 efivar_entry_iter+0x29/0x150=0A=
 efivarfs_kill_sb+0x2f/0x40=0A=
 deactivate_locked_super+0xa6/0x190=0A=
 vfs_get_super+0x235/0x2b0=0A=
 get_tree_single+0x2b/0x40=0A=
 efivarfs_get_tree+0x21/0x30=0A=
 vfs_get_tree+0x97/0x370=0A=
 __do_sys_fsconfig+0x981/0xd20=0A=
 __x64_sys_fsconfig+0xc1/0x150=0A=
 do_syscall_64+0x3f/0x90=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
RIP: 0033:0x7fafd8e8edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007fafd9f82bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af=0A=
RAX: ffffffffffffffda RBX: 00007fafd8fbbf80 RCX: 00007fafd8e8edcd=0A=
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004=0A=
RBP: 00007fafd8efc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007fff23221a7f R14: 00007fff23221c20 R15: 00007fafd9f82d80=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:efivar_lock+0x4e/0xa0=0A=
Code: a8 28 0f fc 45 85 e4 75 3f e8 ee 2c 0f fc 48 8b 1d b7 aa c5 05 48 b8 =
00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3=
9 48 83 7b 08 00 74 19 e8 c0 2c 0f fc 44 89 e0 5b=0A=
RSP: 0018:ffff88802549fca8 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003cb0000=0A=
RDX: 0000000000000001 RSI: ffffffff85792a42 RDI: 0000000000000008=0A=
RBP: ffff88802549fcb8 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000=0A=
R13: 0000000000000000 R14: ffffffff82595920 R15: 0000000000000000=0A=
FS:  00007fafd9f83700(0000) GS:ffff88811a800000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f9e23270d78 CR3: 00000000233bb000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess), 1 bytes skipped:=0A=
   0:	28 0f                	sub    %cl,(%rdi)=0A=
   2:	fc                   	cld=0A=
   3:	45 85 e4             	test   %r12d,%r12d=0A=
   6:	75 3f                	jne    0x47=0A=
   8:	e8 ee 2c 0f fc       	call   0xfc0f2cfb=0A=
   d:	48 8b 1d b7 aa c5 05 	mov    0x5c5aab7(%rip),%rbx        # 0x5c5aacb=
=0A=
  14:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax=0A=
  1b:	fc ff df=0A=
  1e:	48 8d 7b 08          	lea    0x8(%rbx),%rdi=0A=
  22:	48 89 fa             	mov    %rdi,%rdx=0A=
  25:	48 c1 ea 03          	shr    $0x3,%rdx=0A=
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruct=
ion=0A=
  2d:	75 39                	jne    0x68=0A=
  2f:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)=0A=
  34:	74 19                	je     0x4f=0A=
  36:	e8 c0 2c 0f fc       	call   0xfc0f2cfb=0A=
  3b:	44 89 e0             	mov    %r12d,%eax=0A=
  3e:	5b                   	pop    %rbx=0A=
