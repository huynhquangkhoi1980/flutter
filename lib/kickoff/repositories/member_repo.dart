import 'package:dartz/dartz.dart';
import 'package:mevn_app/app/utils/repositories/base_repository.dart';
import 'package:mevn_app/kickoff/models/member_res.dart';
import 'package:mevn_app/kickoff/services/member_service.dart';

class MemberRepo extends BaseRepository {
  final MemberService memberService;

  MemberRepo({required this.memberService});

  Future<Either<MemberRes, Exception>> getdata() {
    return safeCall(memberService.getdata);
  }

  Future<int> getCountMember() async {
    return memberService.getCountMember();
  }
}
