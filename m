Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33453CFCEE
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbhGTOXT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:19 -0400
Received: from mail-dm3nam07on2090.outbound.protection.outlook.com ([40.107.95.90]:57825
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239118AbhGTORx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTng3zLPfomOnFJoJugBAz+C1CBG30a1qh+e/vFP5uvv6HKlJ969h3TuCnyOH4U8icbYRUxJWOKnmUtzE4KTwhC0jtYcS1Dkj20ij97gds/y/kGOyp7RoObJe3kQTfqFUTdqBb0QBjBoPesPmuIb6EWh5j0n2arkTSS2RaM+yRAkWWQAop2TteF24XPsHv1ocfNnaoAZXDKhNMDj7HImqqcgjIRXx10IYZTe29XaCAxsYkwpcfWuCVRG3aHMi07g27odlMeYZXuY0ZBbEZ4yjF52lvpCuwkZFscwZQ0VfqN8J7QyAXw0gAML5noCjnA26V1EqVeB8TZbf86se/0pEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuFWaHyaNoPq2Yo41iX4G9GZNIw/9Q3IvwLSkmfIsOI=;
 b=Voj1fmt1m28uCPaP1VSy0i1uBBu3pDqkXo5PONBZ5pXRk9FHEQJ7Vop3HpOGULk190vxf7VGppE306SQHS9AxkTsnEt8UrqD9et+nqqYD3hv0J2GrYEekRw5ZwU8e40Lzl0f32BYJv3o6aY4pF4/czqQUcyICXz29wCrQIWTc+xUyT4OqSlIjXePpgcbnNsmuyAYOKKpy3GFF55he+B8b/ke3LMa31t4ARCcmA/+qYsAx+KHxPB5M+mprQQyMjEHc67bp/dF0g8f4WqRZfQZS793UUJdknWJ9seW8Fuy7Gvxyvl0TNCp+kOAuiXj+cGyARPUoX9XvK0tK1UjcC2hqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuFWaHyaNoPq2Yo41iX4G9GZNIw/9Q3IvwLSkmfIsOI=;
 b=ZzNhsPwYO/47VvL9R1DwKdrU3tfGz4OVZGDNdQMUA66mUNv//nONl6JKxtKjbEjRvbqqPGHJK1oOCHxV0X32u0njiban38fx0fUxiUSUwHw8f+9f4UDo7DI9By6nAup1KU4+ylKe+KP25eMul9QpIRO6Qf6L4LV3roxgPKkW+To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 14:57:24 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5%9]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 14:57:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v11 2/5] arm64: hyperv: Add panic handler
Date:   Tue, 20 Jul 2021 07:57:00 -0700
Message-Id: <1626793023-13830-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca4d9c9-994c-45e7-fd90-08d94b8eaefa
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB098133BBB018B024CCBC3951D7E29@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1NMPYSzqXNNSZwQbBSpuK1pE4dNZj6g4n+9Z0Rgww0fevKsVjKiz23sRaHLobS9zKgxEbCQ05c+ctxHC+hhADS1Fv7dsbjLVitmv2Liz/5BEZrDX4LVe8TwpuZyfrXmd5iR1b7IpLIVb4ZoqzOFZBm/GA+vv2yiCfMFxtSHJBWsQp2YT6xRN2Rr3ZWFMZ3PO5jRyme9vh7f6kDzBin92AgkztPetP73LummL6QrjwSOWH5ZsEFuSc8A73lElyolysZYm1Vil5CBOZm6is8WjG5oZrm4usG2CA6vaR2i3dK1CmEIKGpWcYDWowYIocHPTEVEAQGbdTx1Af92vVHgb4ESBevROuUwf2lr2ZWGvzjNl9W/sZOsTuJ77NjlTPob7dmYuQVtBfA67nfiIr0mQ926n/XIs9yeOBKHmw80mh124QxRj2ElubruZAIdVBPxOw5wO2HwyrCIaJ0jtosjLTeU8wVT0jlRVpNzSIug4PQzGLEgFdEZT3FFi46gLEbkc6dMZb8LjUD5yMq33dX67l+/EiPNcWrnD3x3lwid1I4oB1LmjFLtwJtWQMQiFvujRAnBvgzKSUbctbsEBJ/l5WdX3zOO5S1CczNNsWm4RE7iscqe+sw0iHKQoeTakJfn9HMjF5Ye/CGifGw6URleMq1nhDJ0RQdqIKCegJot8YhwoONGLq/RaPxFYQB4QCVNWvhOXkz8X0QhDLYttPI2vDcupWGiTi421n5c+EjXdhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(6666004)(36756003)(508600001)(956004)(10290500003)(66476007)(5660300002)(38350700002)(4326008)(8676002)(38100700002)(66946007)(2616005)(82950400001)(186003)(52116002)(7696005)(107886003)(6486002)(8936002)(82960400001)(316002)(921005)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sec1WlMh/DHDTT3XbIWy7vQnc1XnIl90aiFqZv3KhwM9tgKXu/ychYMdRDzk?=
 =?us-ascii?Q?rsEmbMi9/m7exxs+AKhX4zvd6TOWM9WKaoFbHch8rYOUAcV5RfkLEgEjbMaD?=
 =?us-ascii?Q?Stpy6RQot31UsPiY2KcHwNa3bb1JOXiz2rZ6e0jbSw7OQ2nvuz4spJz+e7f9?=
 =?us-ascii?Q?C6QIc3n6uXM1fLPSpPJjAYn5WHMSu/tLSask1n+ApAKMd7CMDTVu+e9DVNuW?=
 =?us-ascii?Q?iAew0/svVXDZk/KEXIP0IjV8yC+ejO8Giwq9aK2hQJK5q9gv3imqupUJicyZ?=
 =?us-ascii?Q?9FZWFcHJ5KdmZ01laC+o9RxyRA94UyJVMBg74N/iGS0d5b6YUhVpliR2/wjy?=
 =?us-ascii?Q?dBT+5ZVcmIsnmzLHfAnyQ1xspNyt+odvg7qjAlUDoUgcSuthmyjUImOWodEd?=
 =?us-ascii?Q?pfWc4GcFxh+Rjbz55v9lhgTvPyLWViEG7CdlLog81FUT+mT649XADj4L+Osb?=
 =?us-ascii?Q?84Q9txT+D+n2ghfzgW7nboZjNhvhNhLcF6mWWyMUvHDiTMrkUAsSzE2kBJt8?=
 =?us-ascii?Q?gyje7PsEMk3rmJZ5mW/9pPnJgt/iUkdO+xcopaggAC4lU88YibRFE8V0F0Ct?=
 =?us-ascii?Q?wyZS9nBaITEJ3d4+75YtE33dHayOfmpF42n9C7wTaHmvrNIZd+wdULC/Abhs?=
 =?us-ascii?Q?4y67iSBWuuAy8ixTWmyXKoA3s0U02cZDE9SgeGJk6RV2mCB3K2couJbiEdtI?=
 =?us-ascii?Q?QE5QANKerEJ9VfG+wbfmdK6jqZ9QLqsHNBvhJXrmOazVPpJR0CzQ0IMNMgLg?=
 =?us-ascii?Q?Jd49uqpmnzxVmmp17BjMOf3+GzmWezXFZcm8NnWBov7rjQJOsMt4XenFhZwm?=
 =?us-ascii?Q?v4AcCM2kH+OJYDhfPAFkBm9p6EBIBro56HGXyPypPNci3HH6ZVsK5jmepweC?=
 =?us-ascii?Q?v0Tlc/CS5qx9VI9HPEGHNwKBW0Zqb0ii5pgyP20l5YiKpkQkhvO0e0owz4cw?=
 =?us-ascii?Q?wWHReWKGMlNdwdpFyX3KBt+YqLUQezdKI1EdjRA6ornTq8IjHJ2TyhGXoXx5?=
 =?us-ascii?Q?/T+IdGP7I2oCSxszdp9uUKvqqAYD3Ie/ve9BdiCSx/74QCJEXR4AHCUh+wnQ?=
 =?us-ascii?Q?Ky56iiPjTzV3+gZm2bIA5v0YG0A7kr4eNs/p/su0LNrajd3aoVfCObKxkPqj?=
 =?us-ascii?Q?zjBaSeWaN7mYWWM/5fHac+o3qw98+Rc/nadYkArNoHYidF7cj6db7D8uwF5V?=
 =?us-ascii?Q?uwfMuXeyMqwMGntGv1+IMsbl8Vn19mmk1VmViPgx1bvMADLh4tVWARgecF+s?=
 =?us-ascii?Q?Of9ei/aYQEFIJXn+ZrKD3pPS3wwxAJPu6McXKlnxI1BzmRBhvaZF67uoANUt?=
 =?us-ascii?Q?PEZop/9PAtx/qSONhOq0GaMU?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4d9c9-994c-45e7-fd90-08d94b8eaefa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:24.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qafxP4iJu7l8uaEWwWE+r0t6H8p9cZ7l1pr39ZkYQSyBLzoLz3lVGQ5BUfzOyI1opAVE7ismycCZXEyhpPSxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a function to inform Hyper-V about a guest panic.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/hv_core.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 4c5dc0f..b54c347 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -127,3 +127,55 @@ u64 hv_get_vpreg(u32 msr)
 	return output.as64.low;
 }
 EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+/*
+ * hyperv_report_panic - report a panic to Hyper-V.  This function uses
+ * the older version of the Hyper-V interface that admittedly doesn't
+ * pass enough information to be useful beyond just recording the
+ * occurrence of a panic. The parallel hv_kmsg_dump() uses the
+ * new interface that allows reporting 4 Kbytes of data, which is much
+ * more useful. Hyper-V on ARM64 always supports the newer interface, but
+ * we retain support for the older version because the sysadmin is allowed
+ * to disable the newer version via sysctl in case of information security
+ * concerns about the more verbose version.
+ */
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
+{
+	static bool	panic_reported;
+	u64		guest_id;
+
+	/* Don't report a panic to Hyper-V if we're not going to panic */
+	if (in_die && !panic_on_oops)
+		return;
+
+	/*
+	 * We prefer to report panic on 'die' chain as we have proper
+	 * registers to report, but if we miss it (e.g. on BUG()) we need
+	 * to report it on 'panic'.
+	 *
+	 * Calling code in the 'die' and 'panic' paths ensures that only
+	 * one CPU is running this code, so no atomicity is needed.
+	 */
+	if (panic_reported)
+		return;
+	panic_reported = true;
+
+	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
+
+	/*
+	 * Hyper-V provides the ability to store only 5 values.
+	 * Pick the passed in error value, the guest_id, the PC,
+	 * and the SP.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->sp);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, 0);
+
+	/*
+	 * Let Hyper-V know there is crash data available
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic);
-- 
1.8.3.1

